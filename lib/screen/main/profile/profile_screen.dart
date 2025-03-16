import 'dart:io';

import 'package:amin_qassob/screen/auth/offerta_screen.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:provider/provider.dart';

import '../../../generated/assets.dart';
import '../../../provider/providers.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/pref_utils.dart';
import '../../../utils/utils.dart';
import '../../auth/login_screen.dart';
import '../../splash/splash_screen.dart';
import '../aboutapp/about_app_screen.dart';
import '../orders/orders_screen.dart';
import '../report/report_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  PackageInfo? _packageInfo;

  @override
  void didChangeDependencies() {
    getPackageInfo();

    super.didChangeDependencies();
  }

  void getPackageInfo() async {
    var packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = packageInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: _buildBodyHeader(),
              ),
            ]),
          ),
          SliverList.list(children: [
            if (PrefUtils.getToken() != "")
              _buildOption("Buyurtmalar", IconsaxOutline.bag_2, 1.1, BLACK, () {
                startScreenF(context, const OrdersScreen());
              }),
            // if (PrefUtils.getToken() != "")
            //   _buildOption("cashback_report".tr(), Assets.profileReport, 1.1, COLOR_PRIMARY, () {
            //     if (PrefUtils.getToken().isEmpty) {
            //       PersistentNavBarNavigator.pushNewScreen(
            //         context,
            //         screen: LoginScreen(),
            //         withNavBar: false,
            //         pageTransitionAnimation: PageTransitionAnimation.cupertino,
            //       );
            //       return;
            //     }
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (_) => ReportScreen(
            //                   reportType: REPORT_CASHBACK,
            //                 )));
            //   }),

            // if (PrefUtils.getToken() != "")
            //   _buildOption("Hisobotlar", Assets.profileFilter2x, 2, COLOR_PRIMARY, () {
            //     if (PrefUtils.getToken().isEmpty) {
            //       startScreenF(context, LoginScreen());
            //       return;
            //     }
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (_) => ReportScreen(
            //                   reportType: REPORT_LIST,
            //                 )));
            //   }),
            _buildOption("Ommaviy Offerta", IconsaxOutline.profile_tick, 1.1, BLACK, () {
              startScreenF(context, const OffertaScreen());
            }),
            _buildOption("Ilova haqida", IconsaxOutline.information, 2, BLACK, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutAppScreen()));
            }),
            _buildOption("Ilovani ulashing", IconsaxOutline.share, 1.1, BLACK, () {
              Share.share('https://play.google.com/store/apps/details?id=${_packageInfo?.packageName}');
            }),
            _buildOption("Biz bilan bog'laning", IconsaxOutline.call, 1.5, BLACK, () {
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
                                "Raqamni tanlang",
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
                                      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
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
            }),
            if (PrefUtils.getToken() != "")
              Consumer<Providers>(
                builder: (context, provider, child) {
                  return _buildOption("Tizimdan chiqish", IconsaxOutline.logout, 2, GREY, () {
                    showExitDialog(context, "Tizimdan chiqishga ishonchingiz komilmi ?",
                        noButton: true, forSingOut: true, pressOk: () {
                      PrefUtils.setToken("");
                      PrefUtils.clearAll();

                      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const SplashScreen();
                          },
                        ),
                        (_) => false,
                      );
                    });
                  });
                },
              ),
            if (PrefUtils.getToken() != "" && Platform.isIOS)
              Consumer<Providers>(
                builder: (context, provider, child) {
                  return _buildOption("Hisobni o'chirish", IconsaxOutline.profile_delete, 0.9, Colors.red, () {
                    showExitDialog(context, "THisobni o'chirishga ishonchingiz komilmi ?",
                        noButton: true, forSingOut: true, pressOk: () {
                      PrefUtils.setToken("");
                      PrefUtils.clearAll();
                      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const SplashScreen();
                          },
                        ),
                        (_) => false,
                      );
                    });
                  });
                },
              ),
          ])
        ],
      ),
    );
  }

  Widget _buildOption(String title, IconData icon, double scale, Color titleColor, Function onCLick) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 20, right: 16),
      leading: Icon(
        icon,
        color: COLOR_PRIMARY,
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18, color: titleColor),
      ),
      trailing:
          Icon(IconsaxOutline.arrow_right_3),
          // Image(image: const AssetImage(Assets.profileArrowRight2x), color: Colors.grey.shade500, width: 20, height: 20),
      onTap: () => onCLick(),
    );
  }

  Widget _buildBodyHeader() {
    return (PrefUtils.getToken() != "")
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    // Image.asset(
                    //   Assets.imagesAppLogo,
                    //   width: 30,
                    //   height: 30,
                    // ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text('Profil', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(Assets.imagesAvatar),
              ),
              const SizedBox(height: 8),
              Text(PrefUtils.getUser()?.name ?? "Ma'lumot bo'sh",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(height: 4),
              Text(PrefUtils.getUser()?.phone ?? "", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 20),
              Container(
                color: const Color(0xFFEEEEEE),
                height: 1,
                padding: const EdgeInsets.symmetric(horizontal: 24),
              )
            ],
          )
        : Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text("Hisobingizga kiring", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text("Ilovaning barcha imoniyatlaridan foydalanish uchun tizimga kirishingiz talab qilinadi !",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              Container(
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  color: PRIMARY_COLOR,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(4, 8),
                      blurRadius: 20,
                      color: PRIMARY_COLOR.withOpacity(0.25),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(29)),
                    onTap: () {
                      startScreenF(context, LoginScreen());
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tizimga kirish',
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
              ),
              const SizedBox(height: 20),
              Container(
                color: const Color(0xFFEEEEEE),
                height: 1,
                padding: const EdgeInsets.symmetric(horizontal: 24),
              )
            ],
          );
  }
}
