import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/subjects.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class LocalNotificationService {
//   // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   // FlutterLocalNotificationsPlugin();
//
//   static Future<void> checkNotificationPermission() async {
//     final PermissionStatus status = await Permission.notification.request();
//     if (!status.isDenied) {
//       // Notification permissions granted
//     } else if (status.isDenied) {
//       // Notification permissions denied
//     } else if (status.isPermanentlyDenied) {
//       // Notification permissions permanently denied, open app settings
//       await openAppSettings();
//     }
//   }
//
//   String selectedNotificationPayload = '';
//
//   final BehaviorSubject<String> selectNotificationSubject =
//   BehaviorSubject<String>();
//   initializeNotification() async {
//     tz.initializeTimeZones();
//     _configureSelectNotificationSubject();
//     await _configureLocalTimeZone();
//     // await requestIOSPermissions(flutterLocalNotificationsPlugin);
//     // final IOSInitializationSettings initializationSettingsIOS =
//     // IOSInitializationSettings(
//     //   requestSoundPermission: false,
//     //   requestBadgePermission: false,
//     //   requestAlertPermission: false,
//     //   onDidReceiveLocalNotification: onDidReceiveLocalNotification,
//     // );
//
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     final InitializationSettings initializationSettings =
//     InitializationSettings(
//       // iOS: initializationSettingsIOS,
//       android: initializationSettingsAndroid,
//     );
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       //
//       // onSelectNotification: (String? payload) async {
//       //   if (payload != null) {
//       //     debugPrint('notification payload: ${payload}');
//       //   }
//       //   selectNotificationSubject.add(payload??"");
//       // },
//     );
//   }
//
//   displayNotification({required String title, required String body}) async {
//     print('doing test');
//     var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//         "your channel id",
//         "your channel name",
//         // "Your description",
//         icon: "@mipmap/ic_launcher",
//         importance: Importance.max,
//         priority: Priority.high);
//
//     // var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         // iOS: iOSPlatformChannelSpecifics
//     );
//     await flutterLocalNotificationsPlugin.show(
//       DateTime.now().millisecondsSinceEpoch ~/ 1000,
//       title,
//       body,
//       platformChannelSpecifics,
//       payload: 'Default_Sound',
//     );
//   }
//
//   // this is the scheduled notification
//   // Task is a model class have a data item like title, desc, start time and end time
//   // scheduledNotification(int hour, int minutes, Task task) async {
//   //   await flutterLocalNotificationsPlugin.zonedSchedule(
//   //     task.id!,
//   //     task.title,
//   //     task.note,
//   //     //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//   //     _nextInstanceOfTenAM(hour, minutes),
//   //     const NotificationDetails(
//   //       android: AndroidNotificationDetails(
//   //           'your channel id', 'your channel name', 'your channel description'),
//   //     ),
//   //     androidAllowWhileIdle: true,
//   //     uiLocalNotificationDateInterpretation:
//   //     UILocalNotificationDateInterpretation.absoluteTime,
//   //     matchDateTimeComponents: DateTimeComponents.time,
//   //     payload: '${task.title}|${task.note}|${task.startTime}|',
//   //   );
//   // }
//
//   tz.TZDateTime _nextInstanceOfTenAM(int hour, int minutes) {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//     tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }
//
//   void requestIOSPermissions(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
//
//   Future<void> _configureLocalTimeZone() async {
//     tz.initializeTimeZones();
//     final String timeZoneName = await FlutterTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZoneName));
//   }
//
// /*   Future selectNotification(String? payload) async {
//     if (payload != null) {
//       //selectedNotificationPayload = "The best";
//       selectNotificationSubject.add(payload);
//       print('notification payload: $payload');
//     } else {
//       print("Notification Done");
//     }
//     Get.to(() => SecondScreen(selectedNotificationPayload));
//   } */
//
// //Older IOS
//   Future onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     // display a dialog with the notification details, tap ok to go to another page
//     /* showDialog(
//       context: context,
//       builder: (BuildContext context) => CupertinoAlertDialog(
//         title: const Text('Title'),
//         content: const Text('Body'),
//         actions: [
//           CupertinoDialogAction(
//             isDefaultAction: true,
//             child: const Text('Ok'),
//             onPressed: () async {
//               Navigator.of(context, rootNavigator: true).pop();
//               await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Container(color: Colors.white),
//                 ),
//               );
//             },
//           )
//         ],
//       ),
//     );
//  */
//     Get.dialog( Text(body!));
//   }
//   //I used Get package Get here to go screen notification
//   void _configureSelectNotificationSubject() {
//     selectNotificationSubject.stream.listen((String payload) async {
//       debugPrint('My payload is ' + payload);
//       // await Get.to(() => MainScreen(payload));
//     });
//   }
// }
