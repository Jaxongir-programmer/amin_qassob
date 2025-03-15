import 'dart:async';

import 'package:badges/badges.dart' as badges;
import 'package:amin_qassob/screen/auth/login_screen.dart';
import 'package:amin_qassob/screen/main/brands_screen/catalog_scr.dart';
import 'package:amin_qassob/screen/main/home/home2.dart';
import 'package:amin_qassob/screen/main/home/home_viewmodel.dart';
import 'package:amin_qassob/screen/main/profile/profile_screen.dart';
import 'package:ficonsax/ficonsax.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../generated/assets.dart';
import '../../model/event_model.dart';
import '../../provider/providers.dart';
import '../../service/local_notification_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../service/eventbus.dart';
import '../../utils/pref_utils.dart';
import '../../utils/size_config.dart';
import '../../utils/utils.dart';
import 'brands_screen/brands_screen.dart';
import 'cart/cart_screen.dart';
import 'favorites/favorites_screen.dart';
import 'message/message_screen.dart';

class MainScreen extends StatefulWidget {
  // final int selectedIndex;

  MainScreen({/*this.selectedIndex = 0,*/ Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var badge = 0;
  DateTime timeBackPressed = DateTime.now();
  StreamSubscription? _busEventListener;


  List<Widget> _screens() {
    return [HomeScreen2(), CatalogScreen(), CartScreen(), ProfileScreen()];
  }



  @override
  void dispose() {
    _busEventListener?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // FirebaseMessaging.instance.getInitialMessage();
    //
    // FirebaseMessaging.onMessage.listen((message) {
    //   if (message.notification != null) {
    //     print(message.notification!.body);
    //     print(message.notification!.title);
    //     // LocalNotificationService()
    //     //     .displayNotification(title: message.notification?.title ?? "", body: message.notification?.body ?? "");
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<Providers>(builder: (context, provider, child) {
      return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () {
          return HomeViewModel();
        },
        builder: (context, viewModel, child) {
          return WillPopScope(
            onWillPop: () async{
              if (provider.getIndex()!=0) {
                provider.setIndex(0);
                return false;
              }  else{
                final differeance = DateTime.now().difference(timeBackPressed);
                timeBackPressed = DateTime.now();
                if (differeance >= const Duration(seconds: 2)) {
                  Fluttertoast.showToast( msg:"Chiqish uchun yana bir marta bosing!", );
                  return Future.value(false);
                }
                SystemNavigator.pop();
                return true;
              }
            },
            child: SafeArea(
              child: Scaffold(
                body: IndexedStack(index: provider.getIndex(), children: _screens()),
                bottomNavigationBar: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                      label: "Asosiy",
                      activeIcon: Icon(
                        IconsaxBold.home,
                        size: 24,
                        color: PRIMARY_DARK_COLOR,
                      ),
                      icon: Icon(
                        IconsaxOutline.home,
                        size: 24,
                        color: BLACK,
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "Katalog",
                      activeIcon: Icon(
                        IconsaxBold.category,
                        size: 24,
                        color: PRIMARY_DARK_COLOR,
                      ),
                      icon: Icon(
                        IconsaxOutline.category,
                        size: 24,
                        color: BLACK,
                      ),
                    ),
                    // BottomNavigationBarItem(
                    //   label: "Yoqimlilar",
                    //   activeIcon: Image.asset(
                    //     Assets.profileFavorite,
                    //     color: PRIMARY_DARK_COLOR,
                    //   ),
                    //   icon: Image.asset(
                    //     Assets.profileFavorite,
                    //   ),
                    // ),
                    BottomNavigationBarItem(label: "Savat",
                      activeIcon: badges.Badge(
                        showBadge: provider.getCartList.isNotEmpty,
                        badgeContent:
                            Text((provider.getCartList.length).toString(), style: const TextStyle(color: Colors.white)),
                        badgeStyle: const badges.BadgeStyle(badgeColor: RED_COLOR, shape: badges.BadgeShape.circle),
                        badgeAnimation: const badges.BadgeAnimation.scale(),
                        child: Icon(
                          IconsaxBold.shopping_cart,
                          size: 24,
                          color: PRIMARY_DARK_COLOR,
                        ),
                      ),
                      icon: badges.Badge(
                        showBadge: provider.getCartList.isNotEmpty,
                        badgeContent:
                            Text((provider.getCartList.length).toString(), style: const TextStyle(color: Colors.white)),
                        badgeStyle: const badges.BadgeStyle(badgeColor: RED_COLOR, shape: badges.BadgeShape.circle),
                        badgeAnimation: const badges.BadgeAnimation.scale(),
                        child: Icon(
                          IconsaxOutline.shopping_cart,
                          size: 24,
                          color: BLACK,
                        ),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: "Profil",
                      activeIcon: Icon(
                        IconsaxBold.profile_circle,
                        size: 24,
                        color: PRIMARY_DARK_COLOR,
                      ),
                      icon: Icon(
                        IconsaxOutline.profile_circle,
                        size: 24,
                        color: BLACK,
                      ),
                    ),
                  ],
                  onTap: (value) {
                    // selectedScreenIndex = value;
                    provider.setIndex(value);
                  },
                  currentIndex: provider.getIndex(),
                  selectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: PRIMARY_DARK_COLOR,
                    fontSize: 12,
                  ),
                  showUnselectedLabels: true,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: BACKGROUND_COLOR,
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                  selectedItemColor: const Color(0xFF212121),
                  unselectedItemColor: const Color(0xFF9E9E9E),
                ),
              ),
            ),
          );
          // return SafeArea(
          //   child: PersistentTabView(
          //     context,
          //     controller: controller,
          //     screens: _screens(),
          //     items: _navBarsItems(provider),
          //     stateManagement: true,
          //     resizeToAvoidBottomInset: true,
          //     hideNavigationBarWhenKeyboardShows: true,
          //     decoration: NavBarDecoration(
          //         borderRadius: BorderRadius.circular(10.0),
          //         colorBehindNavBar: Colors.black,
          //         border: Border.all(color: Colors.grey.shade300)),
          //     popAllScreensOnTapOfSelectedTab: true,
          //     popActionScreens: PopActionScreensType.all,
          //     itemAnimationProperties: const ItemAnimationProperties(
          //       duration: Duration(milliseconds: 200),
          //       curve: Curves.ease,
          //     ),
          //     screenTransitionAnimation: const ScreenTransitionAnimation(
          //       animateTabTransition: true,
          //       curve: Curves.ease,
          //       duration: Duration(milliseconds: 200),
          //     ),
          //     navBarStyle: NavBarStyle.style13,
          //   ),
          // );
        },
        onViewModelReady: (viewModel) {
          // FirebaseMessaging.instance.getInitialMessage();
          //
          // FirebaseMessaging.onMessage.listen((message) {
          //   if (message.notification != null) {
          //     print(message.notification!.body);
          //     print(message.notification!.title);
          //     // LocalNotificationService().displayNotification(
          //     //     title: message.notification?.title ?? "", body: message.notification?.body ?? "");
          //   }
          // });

          _busEventListener = eventBus.on<EventModel>().listen((event) async {
            if (event.event == EVENT_UPDATE_MESSAGE_BADGE) {
              setState(() {
                badge = event.data;
              });
            }
            // else if (event.event == EVENT_UPDATE_STATE) {
            //   setState(() {
            //     controller.index = event.data;
            //   });
            // } else if (event.event == EVENT_SELECT_CATEGORY) {
            //   setState(() {
            //     controller.index = 1;
            //   });
            //   eventBus.fire(EventModel(event: EVENT_SELECT_BRAND, data: 0));
            // }
          });

          // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
          //   print("onMessageOpenedApp: $message");
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => MessageScreen()));
          // });
        },
      );
    });
  }

  Future<bool> _onWillPop() {
    final differeance = DateTime.now().difference(timeBackPressed);
    timeBackPressed = DateTime.now();
    if (differeance >= Duration(seconds: 2)) {
      showWarning(context, "Chiqish uchun yana bir marta bosing!");
      return Future.value(false);
    }
    SystemNavigator.pop();
    return Future.value(true);
  }
}
