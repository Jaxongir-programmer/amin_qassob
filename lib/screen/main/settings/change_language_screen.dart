import 'package:amin_qassob/utils/app_colors.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/constants.dart';
import '../../../utils/pref_utils.dart';
import '../../../utils/utils.dart';
import '../../splash/splash_screen.dart';
import '../../splash_page_view/page_view.dart';

class ChangeLanguageScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return ChangeLanguageScreenState();
  }
}
class ChangeLanguageScreenState extends State<ChangeLanguageScreen>{
  var isUzbLlang = true;
  var currentLang = PrefUtils.getLang();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 32, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "  Выбрать язык / Tilni tanlash",
              style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: "bold"),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
//russian
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        isUzbLlang = false;
                      });
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: !isUzbLlang ? Colors.blue : Colors.grey, width: !isUzbLlang ? 2 : 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/russian.png",
                            height: 32,
                            width: 32,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text("Русский",
                              style: asTextStyle(
                                size: 16,
                                color: BLACK,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
//uzbek
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      setState(() {
                        isUzbLlang = true;
                      });
                    },
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: isUzbLlang ? Colors.blue : Colors.grey, width: isUzbLlang ? 2 : 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/uzbek.png",
                            height: 32,
                            width: 32,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text("Uzbek",
                              style: asTextStyle(
                                size: 16,
                                color: BLACK,
                              ))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width - 40,
              height: 46,
              onPressed: () async {
                // context.locale = (Locale(isUzbLlang ? UZ_LANG_KEY : RU_LANG_KEY));
                // await PrefUtils.setLang(isUzbLlang ? UZ_LANG_KEY : RU_LANG_KEY);
                // await Get.updateLocale(Locale(PrefUtils.getLang()));
                // if (mounted) {
                //   Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                //     MaterialPageRoute(
                //       builder: (BuildContext context) {
                //         return PrefUtils.isFirstRun() ? SplashViewPagerScreen() : SplashScreen();
                //       },
                //     ),
                //     (_) => false,
                //   );
                // }
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              color: PRIMARY_LIGHT_COLOR,
              child: const Text(
                "Davom etish",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}