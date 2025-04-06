
import 'package:amin_qassob/extensions/extensions.dart';
import 'package:amin_qassob/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../generated/assets.dart';
import '../../lang.g.dart';
import '../../utils/enum.dart';
import '../../utils/pref_utils.dart';
import '../splash/splash_screen.dart';

class LanguageScreen extends StatefulWidget {
  final bool first;

  const LanguageScreen({Key? key, required this.first}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  EnumLanguages langId = EnumLanguages.uz;

  @override
  void initState() {
    langId = widget.first ? EnumLanguages.uz : PrefUtils.getLanguage();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // context.setLocale(Locale(langId));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("LanguageScreen");
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(32).copyWith(top: 0),
              child: Image.asset(Assets.imagesLogoMain),
            ),
            Text(LocaleKeys.welcome.tr(),
                textAlign: TextAlign.center, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Text(LocaleKeys.select_lang.tr(),
                textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            ListView(
              shrinkWrap: true,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      langId = EnumLanguages.en;
                      // context.setLocale(const Locale(uzLangKey));
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: langId == EnumLanguages.en ? PRIMARY_LIGHT_COLOR : Colors.white),
                    child: Row(
                      children: [
                        Image.asset(Assets.imagesImgEng, width: 24, height: 24),
                        const SizedBox(width: 16),
                        Expanded(child: Text(EnumLanguages.en.language, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      langId = EnumLanguages.ru;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: langId == EnumLanguages.ru ? PRIMARY_LIGHT_COLOR : Colors.white),
                    child: Row(
                      children: [
                        Image.asset(Assets.imagesImgRus, width: 24, height: 24),
                        const SizedBox(width: 16),
                        Expanded(child: Text(EnumLanguages.ru.language, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      langId = EnumLanguages.ko;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: langId == EnumLanguages.ko ? PRIMARY_LIGHT_COLOR : Colors.white),
                    child: Row(
                      children: [
                        Image.asset(Assets.imagesImgKorea, width: 24, height: 24),
                        const SizedBox(width: 16),
                        Expanded(child: Text(EnumLanguages.ko.language, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      langId = EnumLanguages.uz;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: langId == EnumLanguages.uz ? PRIMARY_LIGHT_COLOR : Colors.white),
                    child: Row(
                      children: [
                        Image.asset(Assets.imagesImgUzb, width: 24, height: 24),
                        const SizedBox(width: 16),
                        Expanded(child: Text(EnumLanguages.uz.language, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                this.context.setLocale(Locale(langId.value));
                await Get.updateLocale(Locale(langId.value));
                await PrefUtils.setLanguage(langId);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashScreen()));
              },
              child: Text(LocaleKeys.continue_.tr().toUpperCase(),style: const TextStyle(color: WHITE,fontSize: 16,fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: 16,)
          ],
        ),
      ),
    );
  }
}
