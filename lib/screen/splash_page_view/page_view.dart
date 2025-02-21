import 'package:amin_qassob/generated/assets.dart';
import 'package:amin_qassob/screen/main/main_screen.dart';
import 'package:amin_qassob/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../utils/pref_utils.dart';

class SplashViewPagerScreen extends StatefulWidget {
  SplashViewPagerScreen({Key? key}) : super(key: key);

  @override
  State<SplashViewPagerScreen> createState() => _SplashViewPagerScreenState();
}

class _SplashViewPagerScreenState extends State<SplashViewPagerScreen> {
  int currentIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  List<AllinOnboardModel> allinonboardlist = [
    AllinOnboardModel(
        Assets.imagesOnlineShopping,
        "Ilovani o'rnating va do'stlaringizga ham taklif qiling. Ilovamiz Android va iOS tizimlari uchun mavjud.",
        "Ilovani o'rnating va boshlang !"),
    AllinOnboardModel(
        Assets.imagesSuccesOrder,
        "Online do'konimizdagi tovarlar bilan tanishib chiqing. Buyurtma berish uchun ro'yhatdan o'ting. Yoqimli mahsulotlaringizni savatga to'plang va buyurtmani tasdiqlang.",
        "Yoqimli savdoni boshlang !"),
    AllinOnboardModel(
        Assets.imagesImg,
        "Biz sizga buyurtmani eshingizgacha bepul yetkazib beramiz. Buning uchun manzilingizni aniq kiritishingizni so'rab qolamiz.",
        "Buyurtmani kutib oling !"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemCount: allinonboardlist.length,
              itemBuilder: (context, index) {
                return PageBuilderWidget(
                    title: allinonboardlist[index].titlestr,
                    description: allinonboardlist[index].description,
                    imgurl: allinonboardlist[index].imgStr);
              }),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                allinonboardlist.length,
                (index) => buildDot(index: index),
              ),
            ),
          ),
          currentIndex < allinonboardlist.length - 1
              ? Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentIndex--;
                            pageController.animateToPage(currentIndex,
                                duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
                            pageController.jumpToPage(currentIndex);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PRIMARY_COLOR,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0), bottomRight: Radius.circular(20.0))),
                        ),
                        child: const Text(
                          "Oldingi",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            currentIndex++;
                            pageController.animateToPage(currentIndex,
                                duration: const Duration(seconds: 1), curve: Curves.easeInOut);
                            pageController.jumpToPage(currentIndex);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PRIMARY_COLOR,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.only(topLeft: Radius.circular(20.0), bottomLeft: Radius.circular(20.0))),
                        ),
                        child: const Text(
                          "Keyingi",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              : Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.2,
                  left: MediaQuery.of(context).size.width * 0.33,
                  child: ElevatedButton(
                    onPressed: () async {
                      await PrefUtils.setFirstRun(false);
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (_) => MainScreen()), (route) => false);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    ),
                    child: const Text(
                      "Boshlash",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentIndex == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentIndex == index ? primarygreen : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class PageBuilderWidget extends StatelessWidget {
  String title;
  String description;
  String imgurl;

  PageBuilderWidget({Key? key, required this.title, required this.description, required this.imgurl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: MediaQuery.of(context).size.height * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Image.asset(
              imgurl,
              width: 200,
              height: 200,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //Tite Text
          Text(title, style: TextStyle(color: primarygreen, fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(
            height: 20,
          ),
          //discription
          Text(description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: primarygreen,
                fontSize: 14,
              ))
        ],
      ),
    );
  }
}

class AllinOnboardModel {
  String imgStr;
  String description;
  String titlestr;

  AllinOnboardModel(this.imgStr, this.description, this.titlestr);
}
