import 'package:amin_qassob/screen/main/message/message_screen.dart';
import 'package:amin_qassob/theme.dart';
import 'package:amin_qassob/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nirikshak/nirikshak.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../provider/providers.dart';
import '../screen/splash/splash_screen.dart';
import '../utils/app_colors.dart';
import '../utils/pref_utils.dart';
import 'model/brand_model.dart';
import 'model/size_model.dart';
import 'model/tip_model.dart';
import 'service/local_notification_service.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   if (message.notification != null) {
//     print(message.notification!.body);
//     print(message.notification!.title);
//     // LocalNotificationService().displayNotification(
//     //     title: message.notification?.title ?? "",
//     //     body: message.notification?.body ?? "");
//   }
//   // await LocalNotificationService.display(message);
//   print('this a message ${message.messageId}');
//   print('this a message ${message.notification?.title}');
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await PrefUtils.initInstance();
  // eventBusProvider();
  // await LocalNotificationService.checkNotificationPermission();
  await Hive.initFlutter();
  // Registering the adapter
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(SizeModelAdapter());
  Hive.registerAdapter(TipModelAdapter());
  // Hive.registerAdapter(ImagesAdapter());
  // Opening the box
  await Hive.openBox<ProductModel>('products_table');
  await Hive.openBox<BrandModel>('brands_table');
  await Hive.openBox<BrandModel>('groups_table');

  // LocalNotificationService().initializeNotification();

  // await Firebase.initializeApp();
  //
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
  //   print("onMessageOpenedApp: $message");
  //   Navigator.push(navigatorKey.currentState!.context, MaterialPageRoute(builder: (context) => const MessageScreen()));
  // });

  // Initialize hive
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale(uzLangKey), Locale(ruLangKey), Locale(uzEnLangKey), Locale(koLangKey)],
      fallbackLocale: const Locale(defaultLangKey),
      startLocale: const Locale(defaultLangKey),
      path: "assets/lang",
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final alice = Nirikshak();

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Offset _offset = Offset.zero;

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: PRIMARY_COLOR,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: PRIMARY_COLOR,
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    return ChangeNotifierProvider<Providers>(
      create: (context) {
        return Providers();
      },
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        // navigatorKey: MyApp.navigatorKey,
        title: 'AMIN QASSOB',
        theme: appTheme(),
        home: const SplashScreen(),
        builder: (context, child) {
          if (_offset.dx == 0) {
            _offset = Offset(MediaQuery.of(context).size.width * .8, MediaQuery.of(context).size.height * .85);
          }
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: Stack(
                children: [
                  child!,
                  if (kDebugMode && false)
                    Positioned(
                      left: _offset.dx,
                      top: _offset.dy,
                      child: GestureDetector(
                        onPanUpdate: (d) => setState(() => _offset += Offset(d.delta.dx, d.delta.dy)),
                        child: FloatingActionButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(56),
                          ),
                          onPressed: () {
                            MyApp.alice.showNirikshak(MyApp.navigatorKey.currentContext!);
                          },
                          backgroundColor: Colors.white.withOpacity(.5),
                          child: const Icon(Icons.http, color: Colors.green, size: 32),
                        ),
                      ),
                    ),
                ],
              ));
        },
      ),
    );
  }
}
