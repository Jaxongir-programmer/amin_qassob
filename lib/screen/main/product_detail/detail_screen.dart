import 'package:amin_qassob/extensions/extensions.dart';
import 'package:amin_qassob/generated/assets.dart';
import 'package:amin_qassob/lang.g.dart';
import 'package:amin_qassob/model/product_model.dart';
import 'package:amin_qassob/provider/providers.dart';
import 'package:amin_qassob/screen/auth/login_screen.dart';
import 'package:amin_qassob/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/pref_utils.dart';
import '../../../utils/size_config.dart';
import '../../../view/custom_views.dart';
import '../../../view/top_product_item_view.dart';
import '../product_list/search_viewmodel.dart';

class ShopDetailScreen extends StatefulWidget {
  ProductModel item;

  ShopDetailScreen({super.key, required this.item});

  @override
  State<ShopDetailScreen> createState() => _ShopDetailScreenState();
}

class _ShopDetailScreenState extends State<ShopDetailScreen> {
  final PageController controller = PageController();
  double totalPrice = 0;
  var cartCount = 0.0;
  var currentPageValue = 0;

  double addCount = 0;

  @override
  void initState() {
    widget.item.cartPrice = widget.item.price;
    cartCount = PrefUtils.getCartCount(widget.item.id);
    totalPrice = cartCount * widget.item.cartPrice;
    addCount = 1;
    super.initState();
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Providers>(
      builder: (BuildContext context, provider, Widget? child) {
        return ViewModelBuilder<SearchViewModel>.reactive(
          viewModelBuilder: () {
            return SearchViewModel();
          },
          builder: (BuildContext context, SearchViewModel viewModel, Widget? child) {
            return Scaffold(
              backgroundColor: BACKGROUND_COLOR,
              body: SafeArea(
                child: Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          expandedHeight: getProportionateScreenHeight(400),
                          leading: IconButton(
                              onPressed: () {
                                finish(context);
                              },
                              icon: const Icon(Icons.arrow_back_ios_new)),
                          flexibleSpace: FlexibleSpaceBar(
                            background: Container(
                              color: const Color(0xFFeeeeee),
                              child: Stack(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    width: MediaQuery.of(context).size.width,
                                    height: 400,
                                    child: PageView.builder(
                                      physics: const ClampingScrollPhysics(),
                                      itemCount: widget.item.photos.length,
                                      // itemCount: 1,
                                      onPageChanged: (int page) {
                                        getChangedPageAndMoveBar(page);
                                      },
                                      controller: controller,
                                      itemBuilder: (context, index) {
                                        var item = widget.item.photos[index];
                                        return CustomViews.buildNetworkImage(item, fit: BoxFit.contain);
                                      },
                                    ),
                                  ),
                                  if(widget.item.photos.isNotEmpty)
                                  Positioned(
                                    right: 10,
                                    left: 10,
                                    bottom: 10,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        for (int i = 0; i < widget.item.photos.length; i++)
                                          if (i == currentPageValue) ...[IndicatorBar(true)] else IndicatorBar(false),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ..._buildTitle(provider),
                                const SizedBox(height: 16),
                                _buildLine(),
                                const SizedBox(height: 16),
                                _buildPrice(),
                                const SizedBox(height: 16),
                                _buildDescription(),
                                const SizedBox(height: 20),
                                _mostTovarTitle(viewModel),
                                const SizedBox(height: 12),
                                _buildMostPopular(viewModel),
                                const SizedBox(height: 125),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    _buldFloatBar(provider)
                  ],
                ),
              ),
            );
          },
          onViewModelReady: (viewModel) {
            viewModel.errorData.listen((event) {
              showError(context, event);
            });

            viewModel.getProductsByBrand(
              "",
              widget.item.brend_id,
            );
          },
        );
      },
    );
  }

  List<Widget> _buildTitle(Providers provider) {
    return <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: widget.item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        TextSpan(
                            text: "  ${widget.item.unit}",
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 18)),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    provider.addToFavorite(widget.item, provider.isFavorite(widget.item.id));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                      provider.isFavorite(widget.item.id) ? Assets.profileHeartFull2x : Assets.profileHeart2x,
                      width: 26,
                      height: 26,
                    ),
                  ),
                  // iconSize: 24,
                ),
              ],
            ),
          ],
        ),
      )
    ];
  }

  Widget _buildLine() {
    return Container(height: 1, color: const Color(0xFFEEEEEE));
  }

  Widget _buildPrice() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // if (widget.item.skidka != 0 && widget.item.skidka != null)
          //   Row(
          //     children: [
          //       Container(
          //         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          //         decoration: const BoxDecoration(
          //           borderRadius: BorderRadius.all(Radius.circular(6)),
          //           color: Colors.redAccent,
          //         ),
          //         child: Text(
          //           "-${widget.item.skidka} %",
          //           style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
          //         ),
          //       ),
          //       const SizedBox(
          //         width: 16,
          //       ),
          //       Text(
          //         "${widget.item.price.formattedAmountString()} ₩",
          //         style: const TextStyle(fontSize: 18, color: Colors.redAccent, decoration: TextDecoration.lineThrough),
          //       )
          //     ],
          //   ),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: [
              Image.asset(
                Assets.profileWallet2x,
                width: 24,
                height: 24,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                widget.item.cartPrice.formattedAmountString(),
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "${" "}/${widget.item.unit}",
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    if (widget.item.description != "") {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocaleKeys.product_description.tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ExpandableText(
              widget.item.description,
              expandText: "ko'proq ko'rish",
              collapseText: "kamroq ko'rsatish",
              linkStyle: const TextStyle(color: Color(0xFF424242), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _mostTovarTitle(SearchViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: (viewModel.productList.length > 1)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(LocaleKeys.similar_products.tr(),
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: Color(0xFF212121))),
                ),
                Icon(
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

  Widget _buildMostPopular(SearchViewModel viewModel) {
    if (viewModel.productList.isNotEmpty) {
      List<ProductModel> newList = [];

      for (var element in viewModel.productList) {
        if (element.id != widget.item.id) {
          newList.add(element);
        }
      }

      return SizedBox(
        height: 200,
        child: ListView.separated(
          padding: const EdgeInsets.only(left: 20, right: 20),
          itemCount: newList.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            var item = newList[index];
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
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  Widget _buldFloatBar(Providers provider) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _buildLine(),
            const SizedBox(height: 21),
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      color: Color(0xFFF3F3F3),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          InkWell(
                            child: const Icon(CupertinoIcons.minus),
                            onTap: () {
                              setState(() {
                                cartCount -= addCount;
                                if (cartCount > 0) {
                                  totalPrice = cartCount * widget.item.cartPrice;
                                } else {
                                  cartCount = 0;
                                  totalPrice = 0;
                                }
                              });
                            },
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(cartCount.formattedAmountString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )),
                              Text(widget.item.unit,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: PRIMARY_COLOR,
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                          const SizedBox(width: 20),
                          InkWell(
                            child: const Icon(CupertinoIcons.plus),
                            onTap: () {
                              setState(() {
                                cartCount += addCount;
                                if (cartCount > widget.item.limit) {
                                  showWarning(context,
                                      "Omborda mahsulot kam!.\n Qoldiq : ${widget.item.limit.formattedAmountString()} dona");
                                  cartCount -= addCount;
                                } else {
                                  totalPrice = cartCount * widget.item.cartPrice;
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  //---------------------------------------------
                  Container(
                    height: 58,
                    width: getProportionateScreenWidth(200),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(29)),
                      color: COLOR_PRIMARY,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(4, 8),
                          blurRadius: 20,
                          color: const Color(0xFF101010).withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: const BorderRadius.all(Radius.circular(29)),
                        onTap: () {
                          if (PrefUtils.getToken() != "") {
                            if (cartCount == 0) return;
                            widget.item.cartCount = cartCount;
                            provider.addToCart = widget.item;
                            finish(context);
                          } else {
                            startScreenF(context, LoginScreen());
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (totalPrice != 0)
                              FittedBox(
                                child: Text("${totalPrice.formattedAmountString()} ₩",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal, color: Colors.white, fontSize: 16)),
                              ),
                            Text(
                              LocaleKeys.add_2_cart.tr(),
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
                  )
                ],
              ),
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}

Widget IndicatorBar(bool isActive) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 150),
    margin: const EdgeInsets.symmetric(horizontal: 8),
    height: isActive ? 8 : 8,
    width: isActive ? 24 : 8,
    decoration: BoxDecoration(
        color: isActive ? ACCENT_COLOR : Colors.grey, borderRadius: const BorderRadius.all(Radius.circular(12))),
  );
}
