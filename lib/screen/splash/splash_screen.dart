import 'dart:async';
import 'dart:io';
import 'package:amin_qassob/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import '../../utils/app_colors.dart';
import '../../utils/pref_utils.dart';
import '../../utils/utils.dart';
import '../main/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var firstTimeRun = true;
  double _width = 30;
  AppUpdateInfo? _updateState;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 200), () {
      setState(() {
        _width = MediaQuery.of(context).size.width;
      });
    });
  }

  @override
  Future<void> didChangeDependencies() async {
    if (firstTimeRun) {
      checkForUpdate();
      firstTimeRun = false;
    }
    // await Firebase.initializeApp();
    // var token = await FirebaseMessaging.instance.getToken();
    // PrefUtils.setFCMToken(token ?? "");
    // print("TOKEN: $token");
    super.didChangeDependencies();
  }

  void checkForUpdate() {
    InAppUpdate.checkForUpdate().then((state) async {
      print("JW update available");
      if (state.updateAvailability == UpdateAvailability.updateAvailable) {
        InAppUpdate.performImmediateUpdate().catchError((e) => print(e));
      }
    }).catchError((e) {
      print(e.toString());
    });
  }

  // void updateLang() async {
  //   showAsBottomSheet(backgroundColor: Colors.white,borderColor: DARK_GREY_FON, context, ChangeLanguageScreen());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              transformAlignment: Alignment.center,
              duration: const Duration(milliseconds: 1500),
              width: _width,
              height: _width,
              alignment: Alignment.center,
              child: Image(
                width: getScreenWidth(context),
                image: const AssetImage(Assets.imagesAppLogo),
              ),
              onEnd: () async {
                startScreenR(
                    context, MainScreen());
              },
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }
}
