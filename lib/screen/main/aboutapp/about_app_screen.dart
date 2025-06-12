// import 'package:easy_localization/easy_localization.dart';
import 'package:amin_qassob/generated/assets.dart';
import 'package:amin_qassob/lang.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../../../utils/app_colors.dart';
import '../../../utils/pref_utils.dart';
import '../../../utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
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
      appBar: AppBar(
        title: Text(LocaleKeys.about_us.tr()),
      ),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              Assets.imagesAminQassob,
              width: 300,
              height: 300,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 80),
              padding: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () async {
                                await UrlLauncher.launchUrl(Uri.parse('https://t.me/Aminqassob'));
                                // await launch('https://t.me/Aminqassob');
                              },
                              icon: Icon(Icons.telegram, size: 32, color: Colors.blue)),
                          SizedBox(
                            height: 4,
                          ),
                          Text("TELEGRAM", style: TextStyle(fontSize: 12, color: PRIMARY_COLOR))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () async {
                                await UrlLauncher.launchUrl(Uri.parse('https://instagram.com/aminqassob'));
                                // await launch('https://instagram.com/aminqassob');
                              },
                              icon: Icon(IconsaxOutline.instagram, size: 32, color: Colors.red)),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "INSTAGRAM",
                            style: TextStyle(fontSize: 12, color: PRIMARY_COLOR),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () async {
                                await UrlLauncher.launchUrl(Uri.parse('https://www.tiktok.com/@aminqassob'));
                              },
                              icon: Icon(Icons.tiktok, size: 32, color: Colors.black)),
                          SizedBox(
                            height: 4,
                          ),
                          Text("QR CODE", style: TextStyle(fontSize: 12, color: PRIMARY_COLOR))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () async {
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
                                                  "Bog'lanish",
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
                                                        padding:
                                                            const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16),
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
                              },
                              icon: Icon(Icons.call, size: 32, color: ACCENT_COLOR)),
                          SizedBox(
                            height: 4,
                          ),
                          Text("CALL", style: TextStyle(fontSize: 12, color: PRIMARY_COLOR))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          if (_packageInfo != null)
            Container(
              alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  "${_packageInfo?.appName}(${Platform.operatingSystem}) v${_packageInfo?.version}(${_packageInfo?.buildNumber})",
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ))
        ],
      ),
    );
  }
}
