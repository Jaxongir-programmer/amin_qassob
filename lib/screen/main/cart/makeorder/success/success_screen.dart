// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../../generated/assets.dart';
import '../../../../../provider/providers.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/utils.dart';
import '../../../main_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Providers>(
      builder: (context, provider, child) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Buyurtmangiz qabul qilindi!",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: BLACK_COLOR),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Image.asset(
                      Assets.imagesSuccesOrder,
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "Xizmatlarimizdan foydalanganingiz uchun rahmat",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: TEXT_COLOR2),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () {
                        provider.setIndex(0);
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => MainScreen()), (route) => false,);
                      },
                      child: Container(
                        width: getScreenWidth(context),
                        height: 45,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 0, left: 12, right: 12, bottom: 8),
                        padding: const EdgeInsets.all(6),
                        decoration:
                            const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6)), color: COLOR_PRIMARY),
                        child: const Text(
                          "Asosiy oynaga qaytish",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
