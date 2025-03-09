import 'package:amin_qassob/model/my_address_model.dart';
import 'package:amin_qassob/provider/providers.dart';
import 'package:amin_qassob/utils/app_colors.dart';
import 'package:amin_qassob/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../../generated/assets.dart';
import '../../../utils/pref_utils.dart';
import '../../auth/login_screen.dart';
import '../cart/makeorder/map/yandex_map.dart';
import '../favorites/favorites_screen.dart';
import '../message/message_screen.dart';
import '../search/search_screen.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  var badge = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<Providers>(
      builder: (BuildContext context, Providers provider, Widget? child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: Image.asset(
                  Assets.imagesAppLogo,
                  width: 40,
                  height: 40,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    addressListDialog(context, provider);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        " Manzil tanlanmagan" ,
                        maxLines: 1,
                        style: TextStyle(
                          color: GREY_COLOR,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            Assets.profileLocation2x,
                            color: PRIMARY_DARK_COLOR,
                            width: 26,
                            height: 26,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            provider.getSelectAdres?.reName ?? "Buyurtma manzili",
                            style: const TextStyle(
                              color: Color(0xFF212121),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(Icons.expand_more_rounded)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  startScreenF(context, SearchScreen());
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    Assets.profileSearch,
                    width: 26,
                    height: 26,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  startScreenF(context, FavoritesScreen());
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    Assets.profileFavorite,
                    width: 26,
                    height: 26,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void addressListDialog(BuildContext context, Providers provider) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.6,
              builder: (BuildContext context, ScrollController scrollController) {
                return Stack(
                  children: [
                    Container(
                      width: getScreenWidth(context),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                        Container(
                          alignment: AlignmentDirectional.center,
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Container(
                            width: 80,
                            height: 10,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0.5, 0.5), blurRadius: 3, spreadRadius: 1.5, color: Colors.grey)
                              ],
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        const Text(
                          "Joylashuv",
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        Expanded(
                          child: (provider.getAdresList.isNotEmpty)
                              ? _buildLocationList(scrollController, provider)
                              : _emptyLocationWidget(context, provider),
                        )
                      ]),
                    ),
                    Positioned(
                      right: 5,
                      top: 0,
                      child: IconButton(
                          onPressed: () {
                            finishScreen(context);
                          },
                          icon: const Icon(Icons.cancel)),
                    )
                  ],
                );
              });
        });
      });
}

Widget _buildLocationList(ScrollController scrollController, Providers provider) {
  return ListView.builder(
      controller: scrollController,
      itemCount: provider.getAdresList.length + 1,
      padding: const EdgeInsets.only(top: 8),
      itemBuilder: (context, index) {
        var addresItem = (index != (provider.getAdresList.length)) ? provider.getAdresList[index] : null;
        return (index != (provider.getAdresList.length))
            ? Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: InkWell(
                  onTap: () {
                    provider.setActiveAdress = addresItem;
                    finish(context);
                  },
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(addresItem?.reName ?? "",
                                    style:
                                        const TextStyle(color: TEXT_COLOR2, fontSize: 16, fontWeight: FontWeight.w500)),
                                Text(addresItem?.name ?? "",
                                    style: const TextStyle(
                                      color: TEXT_COLOR2,
                                      fontSize: 12,
                                    )),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: (addresItem?.isChecked ?? false),
                            child: Image.asset(
                              Assets.imagesChecked,
                              width: 24,
                              height: 24,
                            ),
                          ),
                          Visibility(
                            visible: addresItem?.isChecked == false,
                            child: IconButton(
                                onPressed: () {
                                  showExitDialog(context, "Ushbu manzilni olib tashlaysizmi ?", noButton: true,  pressOk: (){provider.deleteAddress(addresItem!);});

                                },
                                icon: const Icon(
                                  Icons.clear,
                                  size: 20,
                                )),
                          )
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  finish(context);
                 // startScreenF(context, YandexMapScreen2());
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Yangi Manzil Qo'shish",
                    style: TextStyle(color: COLOR_PRIMARY, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              );
      });
}

Widget _emptyLocationWidget(BuildContext context, Providers provider) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        child: Image.asset(
          Assets.imagesMyLocation,
          width: 150,
          height: 150,
        ),
      ),
      Container(
        height: 50,
        margin: const EdgeInsets.only(left: 24, right: 24),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(color: PRIMARY_DARK_COLOR),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(4, 8),
              blurRadius: 20,
              color: PRIMARY_DARK_COLOR.withOpacity(0.25),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(29)),
            onTap: () async {
              finish(context);
             // startScreenF(context, YandexMapScreen2());
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Joylashuvni kiriting",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ],
  );
}
