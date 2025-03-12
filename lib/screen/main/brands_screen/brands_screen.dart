import 'package:amin_qassob/screen/main/home/home_viewmodel.dart';
import 'package:amin_qassob/utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import '../../../model/category_model.dart';
import '../../../model/product_model.dart';
import '../../../provider/providers.dart';
import '../../../view/empty_widget.dart';
import '../../../view/products_item_view.dart';
import '../product_list/product_list_screen.dart';

class BrandsScreen extends StatefulWidget {
  final CategoryModel category;

  BrandsScreen(this.category);

  @override
  State<StatefulWidget> createState() {
    return BrandsScreenState();
  }
}

class BrandsScreenState extends State<BrandsScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<Providers>(
      builder: (context, provider, child) {
        return ViewModelBuilder<HomeViewModel>.reactive(
          viewModelBuilder: () {
            return HomeViewModel();
          },
          builder: (context, viewModel, child) {
            return Scaffold(
              appBar: AppBar(
                title: Text(widget.category.title),
              ),
              body: Stack(
                children: [
                  Column(
                    children: [
                      // SearchField(
                      //   onClickSearch: () {
                      //     startScreenF(context, const SearchScreen());
                      //   },
                      //   onClickFilter: () {
                      //     showFilterDialog();
                      //   },
                      // ),
                      SizedBox(
                        height: 48,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          scrollDirection: Axis.horizontal,
                          // primary: false,
                          padding: const EdgeInsets.only(left: 16, right: 0, top: 0, bottom: 0),
                          // shrinkWrap: true,
                          itemCount: viewModel.brandList.length,
                          itemBuilder: (context, index) {
                            final item = viewModel.brandList[index];
                            return InkWell(
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductListScreen(
                                                brand: item,
                                              )));
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(width: 0.5, color: Colors.grey.withOpacity(0.8))),
                                    child: Text(item.title)));
                          },
                        ),
                      ),
                      Expanded(
                        child: viewModel.productByCategoryList.isNotEmpty
                                ? GridView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: viewModel.productByCategoryList.length,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 0, // horizontal
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.67,
                                        mainAxisSpacing: 4 // vertical
                                        ),
                                    itemBuilder: (_, index) {
                                      ProductModel product = viewModel.productByCategoryList[index];
                                      return ProductsItemView(
                                        item: product,
                                      );
                                    })
                                : EmptyWidget(),
                      ),
                      // Expanded(
                      //   child: ListView.separated(
                      //       shrinkWrap: true,
                      //       primary: false,
                      //       itemBuilder: (ctx, index) {
                      //         BrandModel brand = viewModel.brandList[index];
                      //         return InkWell(
                      //             onTap: () {
                      //               Navigator.push(
                      //                   context,
                      //                   MaterialPageRoute(
                      //                       builder: (_) => ProductListScreen(
                      //                             brand: brand,
                      //                             filterList: widget.filterList,
                      //                           )));
                      //             },
                      //             child: Padding(
                      //               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      //               child: Row(
                      //                 children: [
                      //                   Expanded(
                      //                     child: Text.rich(
                      //                       TextSpan(
                      //                         children: [
                      //                           TextSpan(
                      //                               text: brand.brendName,
                      //                               style: const TextStyle(
                      //                                   color: TEXT_COLOR2,
                      //                                   fontSize: 16,
                      //                                   fontWeight: FontWeight.w500)),
                      //                             TextSpan(
                      //                               text: ' (${(brand.childCount != 0 && brand.childCount!=null) ? brand.childCount : 0})',
                      //                               style: const TextStyle(color: GREY),
                      //                             ),
                      //                         ],
                      //                       ),
                      //                       maxLines: 2,
                      //                       overflow: TextOverflow.ellipsis,
                      //                     ),
                      //                   ),
                      //                   Icon(
                      //                     Icons.arrow_forward_ios_outlined,
                      //                     color: Colors.grey.shade200,
                      //                     size: 15,
                      //                   )
                      //                 ],
                      //               ),
                      //             ));
                      //       },
                      //       separatorBuilder: (ctx, index) {
                      //         return Divider(
                      //           color: Colors.grey.shade100,
                      //           height: 0.5,
                      //         );
                      //       },
                      //       itemCount: viewModel.brandList.length),
                      // ),
                    ],
                  ),
                  if (viewModel.progressData) showMyProgress()
                ],
              ),
            );
          },
          onViewModelReady: (viewModel) {
            loadData(viewModel, widget.category.id);
          },
        );
      },
    );
  }

  void loadData(HomeViewModel viewModel, categoryId) {
    // viewModel.getBrandList(categoryId, keyword);

    viewModel.getBrandList(categoryId);
    viewModel.getProductByCategory(categoryId);
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
                              // TreeView(
                              //   data: treeData ?? [],
                              //   onTap: (treeData) {
                              //     if (treeData.children.isEmpty) {
                              //       // Timer(const Duration(milliseconds: 100), () {
                              //       //   Navigator.pop(context);
                              //       //   Navigator.push(
                              //       //       context,
                              //       //       MaterialPageRoute(
                              //       //           builder: (context) => ProductListScreen(
                              //       //             brand: BrandModel((treeData.extra as FilterBrandModel).id,
                              //       //                     (treeData.extra as FilterBrandModel).text, "", "", [], [], 0),
                              //       //                 filterList: widget.filterList,
                              //       //               )));
                              //       // });
                              //     }
                              //   },
                              // )
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
