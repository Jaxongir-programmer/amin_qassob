import 'dart:async';
import 'package:amin_qassob/screen/main/home/carousel_widget.dart';
import 'package:amin_qassob/screen/main/home/home_viewmodel.dart';
import 'package:amin_qassob/screen/main/search/search_screen.dart';
import 'package:amin_qassob/view/category_circle_item_view.dart';
import 'package:amin_qassob/view/products_item_view.dart';
import 'package:amin_qassob/view/top_product_item_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tree/flutter_tree.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../generated/assets.dart';
import '../../../lang.g.dart';
import '../../../model/brand_model.dart';
import '../../../model/event_model.dart';
import '../../../model/filter_brand_model.dart';
import '../../../model/product_model.dart';
import '../../../provider/providers.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/pref_utils.dart';
import '../../../utils/utils.dart';
import '../../../service/eventbus.dart';
import '../../../view/carousel_item_view.dart';
import '../../../view/shimmers.dart';
import '../../auth/login_screen.dart';
import '../brands_screen/brands_screen.dart';
import '../favorites/favorites_screen.dart';
import '../message/message_screen.dart';
import '../product_list/product_list_screen.dart';
import 'hearder.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  late final Box<ProductModel> box;
  late final Box<BrandModel> brandsBox;
  late final Box<BrandModel> groupsBox;
  var havePr = false;
  var firstTimeLoad = true;
  List<TreeNodeData>? treeData;
  List<FilterBrandModel> filterBrandList = [];

  @override
  void didChangeDependencies() async {
    if (firstTimeLoad) {
      firstTimeLoad = false;
      box = Hive.box<ProductModel>('products_table');
      brandsBox = Hive.box<BrandModel>('brands_table');
      groupsBox = Hive.box<BrandModel>('groups_table');
    }
    super.didChangeDependencies();
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

    return Consumer<Providers>(
      builder: (context, provider, child) {
        List<ProductModel> filterItems = [];
        box.values.forEach((element) {
          if (element.category_id == 0) {
            filterItems.add(element);
            havePr = true;
          }
        });

        return ViewModelBuilder<HomeViewModel>.reactive(
          viewModelBuilder: () {
            return HomeViewModel();
          },
          builder: (context, viewModel, child) {
            return Scaffold(
              backgroundColor: BACKGROUND_COLOR,
              appBar: AppBar(
                backgroundColor: PRIMARY_COLOR,
                // leading: Padding(
                //     padding: EdgeInsets.all(8.0).copyWith(left: 16),
                //     child: Image.asset(
                //       Assets.imagesAvatar,
                //     )),
                title: Container(
                  padding: EdgeInsets.only(left: 16),
                  child: Text("AMIN QASSOB", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: WHITE)),
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      startScreenF(context, SearchScreen());
                    },
                    child: CircleAvatar(
                      backgroundColor: PRIMARY_COLOR.withAlpha(200),
                      child: Icon(
                        IconsaxOutline.search_normal_1,
                        size: 26,
                        color: WHITE,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  InkWell(
                    onTap: () {
                      startScreenF(context, FavoritesScreen());
                    },
                    child: CircleAvatar(
                      backgroundColor: PRIMARY_COLOR.withAlpha(200),
                      child: Icon(
                        IconsaxOutline.heart,
                        size: 26,
                        color: WHITE,
                        // color: PRIMARY_LIGHT_COLOR,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  loadData(viewModel);
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // const SliverPadding(
                      //   padding: EdgeInsets.only(top: 10),
                      //   sliver: SliverAppBar(
                      //     backgroundColor: WHITE,
                      //     flexibleSpace: HomeAppBar(),
                      //     scrolledUnderElevation: 0,
                      //   ),
                      // ),
                      // SliverAppBar(
                      //   backgroundColor: WHITE,
                      //   pinned: true,
                      //   collapsedHeight: 60,
                      //   flexibleSpace: SearchField(
                      //     onClickSearch: () {
                      //       startScreenF(context, const SearchScreen());
                      //     },
                      //     onClickFilter: () {
                      //       showFilterDialog();
                      //     },
                      //   ),
                      //   scrolledUnderElevation: 0,
                      // ),
                      if (viewModel.photosList.isNotEmpty) CarouselWidget(photosList: viewModel.photosList),
                      _connect(context),
                      _buildBody(context, provider, viewModel)
                    ],
                  ),
                ),
              ),
            );
          },
          onViewModelReady: (viewModel) {
            viewModel.errorData.listen((event) {
              showError(context, event);
            });

            viewModel.errorCodeData.listen((event) {
              if (event == 405) {
                PrefUtils.setToken("");
                PrefUtils.clearAll();

                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return LoginScreen();
                    },
                  ),
                  (_) => false,
                );
              }
            });

            viewModel.allProductData.listen((event) async {
              await box.clear();
              await box.addAll(event);
            });

            // viewModel.allBrandsData.listen((event) async {
            //   await brandsBox.clear();
            //   await brandsBox.addAll(event);
            // });

            viewModel.allGroupsData.listen((event) async {
              await groupsBox.clear();
              await groupsBox.addAll(event);
            });

            loadData(viewModel);

            viewModel.allFilterBranData.listen((event) async {
              filterBrandList = event;
              treeData = List.generate(
                event.length,
                (index) => mapServerDataToTreeData(event[index]),
              );
            });
          },
        );
      },
    );
  }

  void loadData(HomeViewModel viewModel) {
    viewModel.getTopTovar();
    viewModel.getSkidkaTovar();
    // viewModel.getBrandList();
    viewModel.getOffer();
    viewModel.getCategoryList();
    viewModel.getProductList();
    // viewModel.getGroupList();
    // viewModel.getFilterBrands();
    if (PrefUtils.getToken().isNotEmpty) {
      viewModel.getUser();
    }
    print("TAG1: " + "${box.values.toList().length}");
    print("TAG2: " + "${brandsBox.values.toList().length}");
  }

  // void showFilterDialog() {
  //   showModalBottomSheet(
  //       isScrollControlled: true,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(18.0)),
  //       ),
  //       backgroundColor: Colors.white,
  //       context: context,
  //       builder: (context) {
  //         return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
  //           return DraggableScrollableSheet(
  //               initialChildSize: 0.7,
  //               maxChildSize: 0.96,
  //               expand: false,
  //               builder: (BuildContext context, ScrollController scrollController) {
  //                 return SingleChildScrollView(
  //                   controller: scrollController,
  //                   child: Column(
  //                     // mainAxisSize: MainAxisSize.min,
  //                     children: <Widget>[
  //                       const SizedBox(
  //                         height: 10,
  //                       ),
  //                       dialogRoundedShapeB(),
  //                       const SizedBox(
  //                         height: 10,
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.symmetric(),
  //                         child: Column(
  //                           children: [
  //                             TreeView(
  //                               data: treeData ?? [],
  //                               onTap: (treeData) {
  //                                 if (treeData.children.isEmpty) {
  //                                   Timer(const Duration(milliseconds: 100), () {
  //                                     Navigator.pop(context);
  //                                     Navigator.push(
  //                                         context,
  //                                         MaterialPageRoute(
  //                                             builder: (context) => ProductListScreen(
  //                                                   brand: BrandModel((treeData.extra as FilterBrandModel).id,
  //                                                       (treeData.extra as FilterBrandModel).text, "",  [], [], 0),
  //                                                   filterList: filterBrandList,
  //                                                 )));
  //                                   });
  //                                 }
  //                               },
  //                             )
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               });
  //         });
  //       });
  // }

  Widget _connect(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () async {
                      await UrlLauncher.launchUrl(Uri.parse('https://t.me/Aminqassob'));
                      // await launch('https://t.me/Aminqassob');
                    },
                    icon: Icon(Icons.telegram, size: 28, color: Colors.blue)),
                // SizedBox(
                //   height: 4,
                // ),
                // Text("TELEGRAM", style: TextStyle(fontSize: 14, color: PRIMARY_COLOR))
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () async {
                      await UrlLauncher.launchUrl(Uri.parse('https://instagram.com/aminqassob'));
                      // await launch('https://instagram.com/aminqassob');
                    },
                    icon: Icon(IconsaxOutline.instagram, size: 28, color: Colors.red)),
                // SizedBox(
                //   height: 4,
                // ),
                // Text(
                //   "INSTAGRAM",
                //   style: TextStyle(fontSize: 14, color: PRIMARY_COLOR),
                // )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () async {
                      await UrlLauncher.launchUrl(Uri.parse('https://www.tiktok.com/@aminqassob'));
                    },
                    icon: Icon(Icons.tiktok, size: 28, color: Colors.black)),
                // SizedBox(
                //   height: 4,
                // ),
                // Text("TIK TOK", style: TextStyle(fontSize: 14, color: PRIMARY_COLOR))
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () async {
                      showDialog<String>(
                          context: context,
                          barrierDismissible: true,
                          barrierColor: Colors.black.withOpacity(0.75),
                          builder: (BuildContext context) {
                            return Dialog(
                              elevation: 20,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                              child: SingleChildScrollView(
                                // controller: scrollController,
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
                                    Container(
                                      padding: const EdgeInsets.only(left: 14),
                                      alignment: AlignmentDirectional.centerStart,
                                      child: const Text(
                                        "Bog'lanish",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    ListView.builder(
                                        padding: const EdgeInsets.only(bottom: 8),
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: PrefUtils.getAdminPhones().length,
                                        itemBuilder: (context, index) {
                                          var item = PrefUtils.getAdminPhones()[index];
                                          return InkWell(
                                            onTap: () {
                                              UrlLauncher.launch("tel:${item.phone}");
                                            },
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.phone_in_talk_sharp,
                                                    color: Colors.green,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    item.phone,
                                                    style: const TextStyle(fontSize: 18),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        })
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    icon: Icon(IconsaxBold.call, size: 28, color: ACCENT_COLOR)),
                // SizedBox(
                //   height: 4,
                // ),
                // Text("CALL", style: TextStyle(fontSize: 14, color: PRIMARY_COLOR))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, Providers provider, HomeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _mostCategoryTitle(viewModel),
        _buildCategory(viewModel),
        _mostTopTovarTitle(viewModel),
        _buildTopTovars(viewModel),
        // const SizedBox(
        //   height: 24,
        // ),
        // SubMenuWiget(
        //   onTapCatalog: () {
        //     provider.setIndex(1);
        //     // eventBus.fire(EventModel(event: EVENT_UPDATE_STATE, data: 1));
        //   },
        //   onTapFavorite: () {
        //     startScreenF(context, SkidkaProductListScreen());
        //
        //     // eventBus.fire(EventModel(event: EVENT_UPDATE_STATE, data: 2));
        //   },
        //   onTapLogin: () {
        //     startScreenF(context, LoginScreen());
        //   },
        //   onTapOrders: () {
        //     startScreenF(context, OrdersScreen());
        //   },
        // ),
        const SizedBox(
          height: 8,
        ),
        _discountProductsTitle(viewModel),
        _buildDiscountProducts(viewModel),
        const SizedBox(
          height: 8,
        ),
        _allProductTitle(viewModel),
        _buildProducts(viewModel),
      ],
    );
  }

  Widget _mostTopTovarTitle(HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 8),
      child: viewModel.topTovarList.isNotEmpty
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(LocaleKeys.top_products.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: PRIMARY_COLOR)),
                ),
                // TextButton(
                //   onPressed: () {},
                //   child: const Text(
                //     "Ko'proq ",
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 16,
                //       color: Color(0xFF212121),
                //     ),
                //   ),
                // ),
                // const Icon(
                //   Icons.keyboard_arrow_right,
                //   size: 20,
                // )
              ],
            )
          : Container(
              height: 0,
            ),
    );
  }

  Widget _buildTopTovars(HomeViewModel viewModel) {
    return viewModel.topTovarProgress
        ? topProductShimmer(context: context)
        : viewModel.topTovarList.isNotEmpty
            ? SizedBox(
                height: 200,
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  itemCount: viewModel.topTovarList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    var item = viewModel.topTovarList[index];
                    return TopProductItemView(
                      item: item,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 15,
                    );
                  },
                ),
              )
            : Container(
                height: 0,
              );
  }

  Widget _discountProductsTitle(HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 8),
      child: viewModel.skidkaTovarList.isNotEmpty
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(LocaleKeys.discount_product.tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: PRIMARY_COLOR)),
                ),
                // TextButton(
                //   onPressed: () {},
                //   child: const Text(
                //     "Ko'proq ",
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 16,
                //       color: Color(0xFF212121),
                //     ),
                //   ),
                // ),
                // const Icon(
                //   Icons.keyboard_arrow_right,
                //   size: 20,
                // )
              ],
            )
          : Container(
              height: 0,
            ),
    );
  }

  Widget _buildDiscountProducts(HomeViewModel viewModel) {
    return viewModel.skidkaTovarProgress
        ? topProductShimmer(context: context)
        : viewModel.skidkaTovarList.isNotEmpty
            ? SizedBox(
                height: 200,
                child: ListView.separated(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  itemCount: viewModel.skidkaTovarList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    var item = viewModel.skidkaTovarList[index];
                    return TopProductItemView(
                      item: item,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 15,
                    );
                  },
                ),
              )
            : Container(
                height: 0,
              );
  }

  Widget _mostCategoryTitle(HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(LocaleKeys.categories.tr(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: PRIMARY_COLOR)),
          ),
          // TextButton(
          //   onPressed: () {
          //   //
          //   },
          //   child: Text(
          //     LocaleKeys.more.tr(),
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       fontSize: 16,
          //       color: PRIMARY_COLOR,
          //     ),
          //   ),
          // ),
          // const Icon(
          //   IconsaxOutline.arrow_right_3,
          //   size: 20,
          //   color: PRIMARY_COLOR,
          // )
        ],
      ),
    );
  }

  Widget _allProductTitle(HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: viewModel.productList.isNotEmpty
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(LocaleKeys.all_products.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: PRIMARY_COLOR)),
                ),
                // TextButton(
                //   onPressed: () {},
                //   child: const Text(
                //     "Ko'proq ",
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 16,
                //       color: Color(0xFF212121),
                //     ),
                //   ),
                // ),
                // const Icon(
                //   Icons.keyboard_arrow_right,
                //   size: 20,
                // )
              ],
            )
          : Container(
              height: 0,
            ),
    );
  }

  Widget _buildProducts(HomeViewModel viewModel) {
    return viewModel.progressData
        ? topProductShimmer(context: context)
        : viewModel.productList.isNotEmpty
            ? GridView.builder(
                padding: const EdgeInsets.only(left: 16, right: 16),
                itemCount: viewModel.productList.length,
                shrinkWrap: true,
                primary: false,
                scrollDirection: Axis.vertical,
                itemBuilder: (ctx, index) {
                  var item = viewModel.productList[index];
                  return ProductsItemView(
                    item: item,
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 0, // horizontal
                    crossAxisCount: 2,
                    childAspectRatio: 0.67,
                    mainAxisSpacing: 4 // vertical
                    ),
              )
            : Container(
                height: 0,
              );
  }

  Widget _buildCategory(
    HomeViewModel viewModel,
  ) {
    return viewModel.categoriesProgress
        ? categoriesShimmer(context: context)
        : SizedBox(
            height: 135,
            child: ListView.builder(
              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              scrollDirection: Axis.horizontal,
              // primary: false,
              padding: const EdgeInsets.only(left: 16, right: 0, top: 0, bottom: 0),
              // shrinkWrap: true,
              itemCount: viewModel.categoryList.length,
              itemBuilder: (context, index) {
                final data = viewModel.categoryList[index];
                return InkWell(
                    onTap: () async {
                      startScreenF(context, BrandsScreen(data));
                    },
                    child: CategoryItemView(
                      item: data,
                      index: index,
                    ));
              },
            ),
          );
  }
}
