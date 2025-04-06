import 'package:amin_qassob/lang.g.dart';
import 'package:badges/badges.dart';
import 'package:easy_localization/easy_localization.dart';

// import 'package:easy_localization/easy_localization.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../generated/assets.dart';
import '../../../model/product_model.dart';
import '../../../provider/providers.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/pref_utils.dart';
import '../../../utils/utils.dart';
import '../../../view/products_item_view.dart';
import '../../auth/login_screen.dart';
import '../main_screen.dart';
import '../product_list/search_viewmodel.dart';
import 'package:badges/badges.dart' as badges;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var keyword = "";
  EventBus eventBus = EventBus();
  var badgeCount = 0;
  bool firstTime = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () {
        return SearchViewModel();
      },
      builder: (context, viewModel, child) {
        return Consumer<Providers>(builder: (context, provider, child) {
          badgeCount = provider.getCartList.length;
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 26,
              title: SizedBox(
                height: 40,
                child: TextField(
                  autofocus: true,
                  onChanged: (text) {
                    keyword = text;
                    setData(viewModel, keyword);
                  },
                  decoration: InputDecoration(
                    hintText: LocaleKeys.search_products.tr(),
                    prefixIcon: Image.asset(
                      Assets.profileSearch,
                      color: PRIMARY_COLOR,
                    ),
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFBDBDBD),
                    ),
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF212121),
                    ),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 14.0),
                  child: InkWell(
                    onTap: () async {
                      if (PrefUtils.getToken().isNotEmpty) {
                        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              provider.setIndex(3);
                              return MainScreen();
                            },
                          ),
                          (_) => false,
                        );
                      } else {
                        startScreenF(context, LoginScreen());
                      }
                    },
                    child: badges.Badge(
                      badgeAnimation: const badges.BadgeAnimation.scale(),
                      showBadge: provider.getCartList.isNotEmpty,
                      badgeContent: Text(
                        (provider.getCartList.length).toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: viewModel.progressData
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      viewModel.getProductList(keyword);
                    },
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        primary: false,
                        itemCount: viewModel.productList.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 0, // horizontal
                            crossAxisCount: 2,
                            childAspectRatio: 0.67,
                            mainAxisSpacing: 4 // vertical
                            ),
                        itemBuilder: (_, index) {
                          ProductModel product = viewModel.productList[index];
                          return ProductsItemView(
                            item: product,
                          );
                        }),
                  ),
          );
        });
      },
      onModelReady: (viewModel) {
        viewModel.errorData.listen((event) {
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(content: Text(event)));
        });

        setData(viewModel, "");
      },
    );
  }

  void setData(SearchViewModel viewModel, keyword) {
    viewModel.getProductList(keyword);
  }
}
