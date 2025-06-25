import 'package:amin_qassob/extensions/extensions.dart';
import 'package:amin_qassob/lang.g.dart';
import 'package:amin_qassob/provider/providers.dart';
import 'package:amin_qassob/screen/main/cart/makeorder/success/success_screen.dart';
import 'package:amin_qassob/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';

// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../../generated/assets.dart';
import '../../../../model/address_model.dart';
import '../../../../model/make_order_model.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/pref_utils.dart';
import '../../../../view/custom_views.dart';
import '../../home/hearder.dart';
import '../map/google_map_screen.dart';
import 'makeorder_viewmodel.dart';

class MakeOrderScreen extends StatefulWidget {
  MakeOrderModel orderModel;

  MakeOrderScreen(this.orderModel, {Key? key}) : super(key: key);

  @override
  _MakeOrderScreenState createState() => _MakeOrderScreenState();
}

class _MakeOrderScreenState extends State<MakeOrderScreen> {
  // MapItemModel? selectMap;
  String deliverDate = "";
  String? deliverDateForLabel;
  final fullNameController = TextEditingController();
  var extraPhoneController = TextEditingController(text: "+82 ");
  var commentController = TextEditingController();
  var orientrController = TextEditingController();
  var phoneFormatter = MaskTextInputFormatter(mask: '+82 ## #### ####', type: MaskAutoCompletionType.eager);

  final List<PaymentModel> paymentTypes = [
    // PaymentModel("click", 1),
    PaymentModel(LocaleKeys.card.tr(), 2),
    // PaymentModel("naqd", 3),
  ];

  String? selectedPayment;
  int? paymentId;

  @override
  Widget build(BuildContext context) {
    return Consumer<Providers>(
      builder: (BuildContext context, Providers provider, Widget? child) {
        return ViewModelBuilder<MakeOrderViewModel>.reactive(
          viewModelBuilder: () {
            return MakeOrderViewModel();
          },
          builder: (BuildContext context, MakeOrderViewModel viewModel, Widget? child) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(LocaleKeys.confirm.tr()),
              ),
              body: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CustomViews.buildTextField(LocaleKeys.name.tr(), LocaleKeys.name.tr(),
                            controller: fullNameController,),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // if (provider.cartSumma <= (PrefUtils.getUser()?.orderSummaLimit ?? 0))
                              //   infowDeliverSummaWidget(provider),
                              phoneAndTimeWidget(),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              // cashBackWidget(),
                              const SizedBox(
                                height: 20,
                              ),
                              addressWidget(provider),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              // genderWidget(),
                              const SizedBox(
                                height: 20,
                              ),
                              commentWidget(),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Divider(),
                          payTypeWidget(),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 2, bottom: 40),
                            child: !viewModel.progressOrderData
                                ? ElevatedButton(
                                    onPressed: () {
                                      if (selectedPayment == null) {
                                        showWarning(context, LocaleKeys.choose_payment.tr());
                                      }
                                      else if (orientrController.text.isEmpty) {
                                        showWarning(context, "Yetkazib berish manzilini tanlang !");
                                      } else if (extraPhoneController.text.isEmpty) {
                                        showWarning(context, "Nomer kiriting !");
                                      }
                                      else if (fullNameController.text.isEmpty) {
                                        showWarning(context, "Ism kiriting !");
                                      }

                                      else {
                                        widget.orderModel.phone2 =
                                            extraPhoneController.text.replaceAll(" ", "").replaceAll("(", "").replaceAll(")", "");
                                        widget.orderModel.full_name = fullNameController.text;
                                        widget.orderModel.comment = commentController.text;
                                        widget.orderModel.order_time = "";
                                        widget.orderModel.lat = provider.getSelectAdres?.lat.toString() ?? "41.2995";
                                        widget.orderModel.lon = provider.getSelectAdres?.long.toString() ?? "69.2401";
                                        widget.orderModel.address = orientrController.text;
                                        widget.orderModel.payment_type = paymentId ?? 3;
                                        viewModel.makeOrder(widget.orderModel);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: PRIMARY_COLOR,
                                      backgroundColor: PRIMARY_COLOR,
                                      shadowColor: PRIMARY_COLOR,
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                    ),
                                    child: Text(
                                      LocaleKeys.confirm.tr().toUpperCase(),
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                                    ))
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            );
          },
          onViewModelReady: (viewModel) {
            viewModel.errorData.listen((event) {
              showError(context, event);
            });

            viewModel.makeOrderData.listen((event) {
              startScreenF(
                  context,
                  SuccessScreen(
                      orderId: event, total_pay: (Providers().cartSumma + widget.orderModel.deliver_summa), back: false));
              PrefUtils.clearCart();
            });
          },
        );
      },
    );
  }

  Widget phoneAndTimeWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300, width: 2)),
      child: InkWell(
        onTap: addPhoneBox,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.phone_number.tr(),
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    extraPhoneController.text.length < 12 ? "" : extraPhoneController.text,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.add,
              color: Colors.grey.shade500,
            )
          ],
        ),
      ),
    );
  }

  Widget addressWidget(Providers provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300, width: 2)),
      child: Column(
        children: [
          InkWell(
            onTap: openOrientrBox,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.orientr.tr(),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        orientrController.text != "" ? orientrController.text : "Mo'ljal kiritilmagan",
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                  color: Colors.grey.shade500,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget payTypeWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.select_payment_type.tr(),
                  style: TextStyle(fontSize: 13),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: 60,
                  width: 120,
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              fontSize: 12,
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12.0),
                            border: OutlineInputBorder()),
                        isEmpty: selectedPayment == '',
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text(
                              LocaleKeys.select_payment_type.tr(),
                              style: TextStyle(fontSize: 12),
                            ),
                            value: selectedPayment,
                            isDense: true,
                            onChanged: (value) {
                              setState(() {
                                selectedPayment = value.toString();
                              });
                              if (selectedPayment == "click") {
                                paymentId = 1;
                              } else if (selectedPayment == "terminal") {
                                paymentId = 2;
                              } else {
                                paymentId = 3;
                              }
                            },
                            items: paymentTypes
                                .map((item) => DropdownMenuItem<String>(
                                      value: item.name,
                                      child: Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                LocaleKeys.total_amount.tr(),
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "${(Providers().cartSumma + widget.orderModel.deliver_summa).formattedAmountString()} ₩",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget commentWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade300, width: 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: openCommentBox,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.comment.tr(),
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        commentController.text == "" ? LocaleKeys.no_comment.tr() : commentController.text,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 20,
                  color: Colors.grey.shade500,
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: Divider(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.delivery_price.tr(),
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "${widget.orderModel.deliver_summa.formattedAmountString()}₩",
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }

  openOrientrBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: Container(
              width: getScreenWidth(context),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Manzil:",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: orientrController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.orientr.tr(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      border: InputBorder.none,
                    ),
                    minLines: 2,
                    maxLines: 6,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const BoxDecoration(
                        color: PRIMARY_COLOR,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        LocaleKeys.save.tr(),
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  openCommentBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: Container(
              width: getScreenWidth(context),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Izoh",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: commentController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: "Izoh",
                      contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                      border: InputBorder.none,
                    ),
                    minLines: 2,
                    maxLines: 6,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const BoxDecoration(
                        color: PRIMARY_COLOR,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        LocaleKeys.save.tr(),
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  addPhoneBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: Container(
              width: getScreenWidth(context),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Qo'shimcha raqam",
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  CustomViews.buildMiniTextField("", "+82 xx xxxx xxxx",
                      maskTextInputFormatter: phoneFormatter,
                      controller: extraPhoneController,
                      autofocus: true,
                      inputType: TextInputType.phone),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const BoxDecoration(
                        color: PRIMARY_COLOR,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Text(
                        LocaleKeys.save.tr(),
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class PaymentModel {
  final String name;
  final int id;

  PaymentModel(this.name, this.id);
}
