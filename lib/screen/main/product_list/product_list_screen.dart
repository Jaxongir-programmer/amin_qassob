import 'dart:async';

import 'package:amin_qassob/model/size_model.dart';
import 'package:amin_qassob/screen/main/product_list/search_viewmodel.dart';
import 'package:badges/badges.dart' as badges;
import 'package:amin_qassob/view/empty_widget.dart';

// import 'package:easy_localization/easy_localization.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tree/flutter_tree.dart';

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
import '../../auth/login_screen.dart';
import '../home/search_field.dart';
import '../main_screen.dart';

class ProductListScreen extends StatefulWidget {
  BrandModel brand;
  final List<FilterBrandModel> filterList;

  ProductListScreen({required this.brand, Key? key, required this.filterList}) : super(key: key);

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  var keyword = "";
  var appBarTitle = "";
  EventBus eventBus = EventBus();
  var badgeCount = 0;
  bool firstTime = true;
  List<TreeNodeData>? treeData;

  @override
  void initState() {
    appBarTitle = widget.brand.brendName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TreeNodeData mapServerDataToTreeData(FilterBrandModel data) {
      return TreeNodeData(
        extra: data,
        title: data.text,
        expaned: data.show,
        checked: data.checked,
        children: List.from((data.children ?? []).map((x) => mapServerDataToTreeData(x))),
      );
    }

// Generate tree data
    treeData = List.generate(
      widget.filterList.length,
      (index) => mapServerDataToTreeData(widget.filterList[index]),
    );

    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () {
        return SearchViewModel();
      },
      builder: (context, viewModel, child) {
        return Consumer<Providers>(builder: (context, provider, child) {
          badgeCount = provider.getCartList.length;
          return Scaffold(
            appBar: AppBar(
              title: Text(appBarTitle),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: InkWell(
                    onTap: () async {
                      if (PrefUtils.getToken().isNotEmpty) {
                        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              provider.setIndex(3);
                              return MainScreen(/*selectedIndex: 3,*/);
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
                  child: viewModel.progressData
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : viewModel.productList.isNotEmpty
                          ? GridView.builder(
                              shrinkWrap: true,
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
                              })
                          : EmptyWidget(),
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

        setData(viewModel, "", );
      },
    );
  }

  void setData(SearchViewModel viewModel, String keyword,) {
    viewModel.getProductsByBrand(keyword, widget.brand.id );
  }

  Widget _buildSearchWidget(SearchViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (text) {
                keyword = text;
                setData(viewModel, keyword);
              },
              decoration: InputDecoration(
                hintText: "amin_qassob'dan izlang...",
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
          const SizedBox(
            width: 8,
          ),
          MaterialButton(
            minWidth: 50,
            onPressed: () {
              clearFocus(context);
              showFilterDialog(viewModel);
            },
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            color: PRIMARY_COLOR,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Image.asset(
              Assets.profileFilter2x,
              width: 26,
              height: 26,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void showFilterDialog(SearchViewModel viewModel) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(18.0)),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
                initialChildSize: 0.7,
                maxChildSize: 0.95,
                expand: false,
                builder: (BuildContext context, ScrollController scrollController) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        dialogRoundedShapeB(),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(),
                          child: Column(
                            children: [
                              TreeView(
                                data: treeData ?? [],
                                onTap: (treeData) {
                                  if (treeData.children.isEmpty) {
                                    Timer(const Duration(milliseconds: 100), () {
                                      viewModel.getProductsByBrand(
                                          keyword, (treeData.extra as FilterBrandModel).id);
                                      Navigator.pop(context);
                                      setState(() {
                                        appBarTitle = treeData.title;
                                      });
                                    });
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          });
        });
  }
}
