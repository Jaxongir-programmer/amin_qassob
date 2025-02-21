import 'dart:async';
import 'package:amin_qassob/screen/main/home/home_viewmodel.dart';
import 'package:amin_qassob/screen/main/home/search_field.dart';
import 'package:amin_qassob/screen/main/home/sub_menu_wiget.dart';
import 'package:amin_qassob/screen/main/orders/orders_screen.dart';
import 'package:amin_qassob/screen/main/product_list/skidka_product_list_screen.dart';
import 'package:amin_qassob/screen/main/search/search_screen.dart';
import 'package:amin_qassob/view/category_circle_item_view.dart';
import 'package:amin_qassob/view/top_product_item_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tree/flutter_tree.dart';
import 'package:hive/hive.dart';

// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../generated/assets.dart';
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
  int _currentIndex = 0;

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
          if (element.category_id.isEmpty) {
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
              body: RefreshIndicator(
                onRefresh: () async {
                  loadData(viewModel);
                },
                child: CustomScrollView(
                  primary: true,
                  slivers: <Widget>[
                    const SliverPadding(
                      padding: EdgeInsets.only(top: 10),
                      sliver: SliverAppBar(
                        backgroundColor: WHITE,
                        flexibleSpace: HomeAppBar(),
                        scrolledUnderElevation: 0,
                      ),
                    ),
                    SliverAppBar(
                      backgroundColor: WHITE,
                      pinned: true,
                      collapsedHeight: 60,
                      flexibleSpace: SearchField(
                        onClickSearch: () {
                          startScreenF(context, const SearchScreen());
                        },
                        onClickFilter: () {
                          showFilterDialog();
                        },
                      ),
                      scrolledUnderElevation: 0,
                    ),
                    SliverToBoxAdapter(
                      child: CarouselSlider.builder(
                          // itemCount: viewModel.photosList.length,
                          itemCount: 5,
                          itemBuilder: (context, index, realIndex) {
                            return CarouselItemView(
                              onClick: () {},
                              index: index,
                              // item: viewModel.photosList[index],
                              item: Constants.photosList[index],
                            );
                          },
                          options: CarouselOptions(
                              height: 190,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.85,
                              initialPage: 0,
                              scrollPhysics: const AlwaysScrollableScrollPhysics(),
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 4),
                              autoPlayAnimationDuration: const Duration(milliseconds: 1200),
                              autoPlayCurve: Curves.easeInSine,
                              //easeInSine,//fastOutSlowIn,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.2,
                              scrollDirection: Axis.horizontal,
                              onPageChanged: (v, a) {
                                setState(() {
                                  _currentIndex = v;
                                });
                              })),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        ((context, index) => _buildBody(context, provider, viewModel)),
                        childCount: 1,
                      ),
                    ),
                  ],
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

            viewModel.allBrandsData.listen((event) async {
              await brandsBox.clear();
              await brandsBox.addAll(event);
            });

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
    viewModel.getBrandList();
    viewModel.getGroupList();
    viewModel.getAdminPhones();
    viewModel.getFilterBrands();
    if (PrefUtils.getToken().isNotEmpty) {
      viewModel.getUser();
    } else {
      viewModel.getCategoryList();
      viewModel.getProductList();
    }
    print("TAG1: " + "${box.values.toList().length}");
    print("TAG2: " + "${brandsBox.values.toList().length}");
  }

  void showFilterDialog() {
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
                maxChildSize: 0.96,
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
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ProductListScreen(
                                                    brand: BrandModel((treeData.extra as FilterBrandModel).id,
                                                        (treeData.extra as FilterBrandModel).text, "", "", [], [], 0),
                                                    filterList: filterBrandList,
                                                  )));
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

  Widget _buildBody(BuildContext context, Providers provider, HomeViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _mostTopTovarTitle(viewModel),
        _buildTopTovars(viewModel),
        const SizedBox(
          height: 24,
        ),
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
        // const SizedBox(
        //   height: 8,
        // ),
        _mostCategoryTitle(viewModel),
        _buildCategory(viewModel),
      ],
    );
  }

  Widget _mostTopTovarTitle(HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: viewModel.topTovarList.isNotEmpty
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Text('Top Mahsulotlar',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF212121))),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Ko'proq ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF212121),
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  size: 20,
                )
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

  Widget _mostCategoryTitle(HomeViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            child: Text('Kategoriyalar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF212121))),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Ko'proq ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF212121),
              ),
            ),
          ),
          const Icon(
            Icons.expand_more,
            size: 20,
          )
        ],
      ),
    );
  }

  Widget _buildCategory(
    HomeViewModel viewModel,
  ) {
    return viewModel.categoriesProgress
        ? categoriesShimmer(context: context)
        : Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              // primary: false,
              padding: const EdgeInsets.only(left: 16, right: 0, top: 0, bottom: 0),
              // shrinkWrap: true,
              itemCount: viewModel.categoryList.length,
              itemBuilder: (context, index) {
                final data = viewModel.categoryList[index];
                return InkWell(
                    onTap: () async {
                      // List<FilterBrandModel> items = [];
                      // for (var i = 0; i < viewModel.filterBrandList.length; i++) {
                      //   if (viewModel.filterBrandList[i].id == data.id) {
                      //     items = viewModel.filterBrandList[i].children;
                      //     break;
                      //   }
                      // }
                      // await PrefUtils.setFilterBrands(items);
                      // startScreenF(context, BrandsScreen(data, PrefUtils.getFilterBrands()));
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
