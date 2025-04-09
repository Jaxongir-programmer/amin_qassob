import 'dart:async';

import 'package:amin_qassob/lang.g.dart';
import 'package:amin_qassob/screen/main/home/home_viewmodel.dart';
import 'package:amin_qassob/utils/constants.dart';
import 'package:amin_qassob/view/shimmers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tree/flutter_tree.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../model/brand_model.dart';
import '../../../model/category_model.dart';
import '../../../model/event_model.dart';
import '../../../model/filter_brand_model.dart';
import '../../../provider/providers.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/pref_utils.dart';
import '../../../utils/utils.dart';
import '../../../service/eventbus.dart';
import '../home/search_field.dart';
import '../product_list/product_list_screen.dart';
import '../search/search_screen.dart';
import 'brands_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({Key? key}) : super(key: key);

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  List<TreeNodeData>? treeData;
  List<FilterBrandModel> filterBrandList = [];

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
        return ViewModelBuilder<HomeViewModel>.reactive(
          viewModelBuilder: () {
            return HomeViewModel();
          },
          builder: (context, viewModel, child) {
            return Scaffold(
              appBar: AppBar(
                title: Text(LocaleKeys.catalog.tr(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
              ),
              body: Column(
                children: [
                  SearchField(
                    onClickSearch: () {
                      startScreenF(context, const SearchScreen());
                    },
                    onClickFilter: () {
                      showFilterDialog();
                    },
                  ),
                  Expanded(
                    child: viewModel.categoriesProgress
                        ? catalogShimmer(context: context)
                        : ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (ctx, index) {
                              final data = viewModel.categoryList[index];
                              return InkWell(
                                  onTap: () {
                                    List<FilterBrandModel> items = [];
                                    for (var i = 0; i < viewModel.filterBrandList.length; i++) {
                                      if (viewModel.filterBrandList[i].id == data.id) {
                                        items = viewModel.filterBrandList[i].children;
                                        break;
                                      }
                                    }
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (_) => BrandsScreen(data)));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                    text: data.title,
                                                    style: const TextStyle(
                                                        color: TEXT_COLOR2, fontSize: 16, fontWeight: FontWeight.w500)),
                                                // TextSpan(
                                                //   text:
                                                //       ' (${(data.childCount != 0 && data.childCount != null) ? data.childCount : 0})',
                                                //   style: const TextStyle(color: GREY),
                                                // ),
                                              ],
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          color: Colors.grey.shade200,
                                          size: 15,
                                        )
                                      ],
                                    ),
                                  ));
                            },
                            separatorBuilder: (ctx, index) {
                              return Divider(
                                color: Colors.grey.shade100,
                                height: 0.5,
                              );
                            },
                            itemCount: viewModel.categoryList.length),
                  ),
                ],
              ),
            );
          },
          onViewModelReady: (viewModel) {
            viewModel.getCategoryList();
            // viewModel.getFilterBrands();

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
                                  // if (treeData.children.isEmpty) {
                                  //   Timer(const Duration(milliseconds: 100), () {
                                  //     Navigator.pop(context);
                                  //     Navigator.push(
                                  //         context,
                                  //         MaterialPageRoute(
                                  //             builder: (context) => ProductListScreen(
                                  //                   brand: BrandModel((treeData.extra as FilterBrandModel).id,
                                  //                       (treeData.extra as FilterBrandModel).text, "", "", [], [], 0),
                                  //                   filterList: filterBrandList,
                                  //                 )));
                                  //   });
                                  // }
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
