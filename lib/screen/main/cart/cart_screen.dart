import 'dart:async';

import 'package:amin_qassob/extensions/extensions.dart';
import 'package:amin_qassob/lang.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../generated/assets.dart';
import '../../../model/event_model.dart';
import '../../../model/make_order_model.dart';
import '../../../model/make_order_product.dart';
import '../../../model/product_id_model.dart';
import '../../../model/products_by_id_model.dart';
import '../../../provider/providers.dart';
import '../../../service/eventbus.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/pref_utils.dart';
import '../../../utils/utils.dart';
import '../../../view/cart_item_layout.dart';
import '../../auth/login_screen.dart';
import '../home/home_viewmodel.dart';
import 'makeorder/make_order_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  StreamSubscription? _busEventListener;
  double deliverSumma = PrefUtils.getUser()?.deliver_summa ?? 0;

  @override
  void dispose() {
    _busEventListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Providers>(builder: (context, provider, child) {
      return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () {
          return HomeViewModel();
        },
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                LocaleKeys.cart.tr(),
                style: TextStyle(color: COLOR_PRIMARY,fontSize: 24, fontWeight: FontWeight.w600),
              ),
              iconTheme: IconThemeData(color: COLOR_PRIMARY),
            ),
            body: Stack(
              children: [
                (PrefUtils.getToken() == "")
                    ? signWidget()
                    : (PrefUtils.getCartList().isEmpty)
                        ? emptyWidget()
                        : Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  primary: true,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ListView.builder(
                                          itemCount: provider.getCartList.length,
                                          primary: false,
                                          shrinkWrap: true,
                                          itemBuilder: (_, position) => CartItemLayout(provider.getCartList[position])),
                                    ],
                                  ),
                                ),
                              ),
                              if (!viewModel.progressCartData && provider.getCartList.isNotEmpty)
                                cartSummaWidget(provider, viewModel)
                            ],
                          ),
                if (viewModel.progressCartData) showMyProgress(),
              ],
            ),
          );
        },
        onViewModelReady: (viewModel) {
          _busEventListener = eventBus.on<EventModel>().listen((event) async {
            if (event.event == EVENT_UPDATE_CART) {
              setState(() {
                provider.clearCart();
              });
            }
          });

          viewModel.errorData.listen((event) {
            showError(context, event);
          });

          viewModel.productsByIdData.listen((event) {
            double deliverSumma = PrefUtils.getUser()?.deliver_summa ?? 0;

            var isHave = false;
            for (var product in event) {
              if (product.cartCount > product.limit || product.limit <= 0) {
                for (var element in provider.getCartList) {
                  if (element.id == product.id) {
                    element.limit = product.limit;
                    break;
                  }
                }
                isHave = true;
              }
            }

            if (isHave) {
              showWarning(context, "${"Iltimos mahsulotlar miqdorini tekshiring"}!");
              provider.notifyListeners();
            } else {
              // PrefUtils.getToken().isNotEmpty
              //     ? PrefUtils.getCartList().isEmpty
              //         ? showWarning(context, "${"Savat boʻsh"}!")
              //         : startScreenF(
              //             context,
              //             MakeOrderScreen(MakeOrderModel(
              //                 PrefUtils.getUser()?.id ?? "",
              //                 PrefUtils.getUser()?.store_id ?? "",
              //                 "",
              //                 "",
              //                 "",
              //                 "",
              //                 "",
              //                 provider.getTotalCashback(),
              //                 deliverSumma,
              //                 provider.cartSumma - provider.getTotalCashback() + deliverSumma,
              //                 3,
              //                 1,
              //                 "",
              //                 "",
              //                 provider.getCartList
              //                     .map((e) => MakeOrderProduct(e.id, e.cartCount, e.cartCount, e.cartPrice))
              //                     .toList())))
              //     : startScreenF(context, LoginScreen());
            }
          });
        },
      );
    });
  }

  Widget cartSummaWidget(Providers provider, HomeViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200, width: 1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                "${LocaleKeys.total_amount.tr()}:",
                style: TextStyle(color: BLACK_COLOR, fontWeight: FontWeight.bold, fontSize: 14),
              )),
              Text(
                provider.cartSumma.formattedAmountString(),
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                LocaleKeys.delivery_price.tr(),
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14),
              )),
              Text(
                (PrefUtils.getUser()?.deliver_summa ?? 0).formattedAmountString(),
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          viewModel.progressCartData
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(PRIMARY_COLOR)),
                  onPressed: () {
                    PrefUtils.getToken().isNotEmpty
                        ? PrefUtils.getCartList().isEmpty
                            ? showWarning(context, "${LocaleKeys.cart_empty.tr()}!")
                            : startScreenF(
                                context,
                                MakeOrderScreen(
                                  MakeOrderModel(
                                      PrefUtils.getUser()?.id ?? "1",
                                      "",
                                      "",
                                      "",
                                      "",
                                      "",
                                      PrefUtils.getUser()?.deliver_summa ?? 0,
                                      1,
                                      "",
                                      provider.getCartList.map((e) => MakeOrderProduct(e.id, e.cartCount, e.cartPrice)).toList()),
                                ))
                        : startScreenF(context, LoginScreen());

                    // viewModel.getProductsByIds(
                    //     ProductByIdModel(PrefUtils.getCartList().map((e) => ProductIdModel(e.id)).toList()));
                  },
                  child: Text(
                    "${LocaleKeys.continue_.tr().toUpperCase()} (${provider.getCartList.length})",
                    style: const TextStyle(color: Colors.white),
                  )),
        ],
      ),
    );
  }

  Widget signWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 24.0, bottom: 10),
          child: Text(LocaleKeys.login_account.tr(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(LocaleKeys.login_access.tr(),
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        ),
        Container(
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            color: PRIMARY_COLOR,
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 8),
                blurRadius: 20,
                color: PRIMARY_COLOR.withOpacity(0.25),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(29)),
              onTap: () {
                startScreenF(context, LoginScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.enter_to_system.tr().toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget emptyWidget() {
    return SizedBox(
      width: getScreenWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.imagesEmptyCart,
            width: 200,
            height: 200,
          ),
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              LocaleKeys.cart_empty.tr(),
              style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w500, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
