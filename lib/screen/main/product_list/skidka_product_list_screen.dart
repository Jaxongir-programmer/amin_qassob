import 'dart:async';

import 'package:amin_qassob/model/size_model.dart';
import 'package:amin_qassob/screen/main/home/home_viewmodel.dart';
import 'package:amin_qassob/screen/main/product_list/search_viewmodel.dart';
import 'package:badges/badges.dart' as badges;
// import 'package:easy_localization/easy_localization.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tree/flutter_tree.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../generated/assets.dart';
import '../../../model/brand_model.dart';
import '../../../model/filter_brand_model.dart';
import '../../../model/product_model.dart';
import '../../../model/tip_model.dart';
import '../../../provider/providers.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/pref_utils.dart';
import '../../../utils/utils.dart';
import '../../../view/custom_views.dart';
import '../../../view/products_item_view.dart';
import '../../../view/shimmers.dart';
import '../../auth/login_screen.dart';
import '../home/search_field.dart';
import '../main_screen.dart';

class SkidkaProductListScreen extends StatefulWidget {

  SkidkaProductListScreen({ Key? key, }) : super(key: key);

  @override
  _SkidkaProductListScreenState createState() => _SkidkaProductListScreenState();
}

class _SkidkaProductListScreenState extends State<SkidkaProductListScreen> {
  var keyword = "";
  EventBus eventBus = EventBus();
  var badgeCount = 0;
  bool firstTime = true;



  @override
  Widget build(BuildContext context) {


    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () {
        return HomeViewModel();
      },
      builder: (context, viewModel, child) {
        return Consumer<Providers>(builder: (context, provider, child) {
          badgeCount = provider.getCartList.length;
          return Scaffold(
            appBar: AppBar(
              title: const Text("Chegirmalar"),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: InkWell(
                    onTap: () async {
                      if (PrefUtils
                          .getToken()
                          .isNotEmpty) {

                        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              provider.setIndex(3);
                              return MainScreen(/*selectedIndex: 3,*/);
                            },
                          ),
                          (_) => false,
                        );
                      }else{
                        startScreenF(context, LoginScreen());
                      }
                    },
                    child: badges.Badge(
                      badgeAnimation: const badges.BadgeAnimation.scale(),
                      showBadge: provider.getCartList.isNotEmpty,
                      badgeContent: Text(
                        // badgeCount.toString(),
                        (provider.getCartList.length).toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      child: const Icon(Icons.shopping_cart_outlined),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                )
              ],
            ),
            body: Column(
              children: [
                _buildSearchWidget(viewModel),
                Expanded(
                  child: viewModel.skidkaTovarProgress
                      ? productsShimmer(context: context)
                      : viewModel.skidkaTovarList.isNotEmpty ? GridView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: viewModel.skidkaTovarList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 0, // horizontal
                              crossAxisCount: 2,
                              childAspectRatio: 0.67,
                              mainAxisSpacing: 4 // vertical
                              ),
                          itemBuilder: (_, index) {
                            ProductModel product = viewModel.skidkaTovarList[index];
                            return ProductsItemView(
                              item: product,
                            );
                          }) : Center(child: Text(
                      textAlign: TextAlign.center,
                      "Hozircha chegirmalar elon qilinmagan.\nYangi chegirmalar haqida albatta ogohlantiramiz"),),
                ),
              ],
            ),
          );
        });
      },
      onViewModelReady: (viewModel) {
        viewModel.errorData.listen((event) {
          showError(context, event);
        });

        loadData(viewModel);
      },
    );
  }

void loadData(HomeViewModel viewModel){
    viewModel.getSkidkaTovar();
}

  Widget _buildSearchWidget(HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (text) {
                keyword = text;
                // filterData(viewModel);
              },
              decoration: InputDecoration(
                hintText: "AMIN QASSOB dan izlang...",
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
        ],
      ),
    );
  }


}
