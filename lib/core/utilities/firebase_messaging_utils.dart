// import 'dart:convert';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';



// class FirebaseMessagingUtils {
//   static final _firebaseMessaging = FirebaseMessaging.instance;
//   static final _localNotification = FlutterLocalNotificationsPlugin();
//   static const _androidChannel = AndroidNotificationChannel(
//     "1",
//     "winit",
//     importance: Importance.max,
//     description: "WinIt would like to send you Notifications",
//     showBadge: true,
//   );

//   //requests push notification permission
//   static requestPushNotificationPermission() async {
//     //await Firebase.initializeApp();
//     _firebaseMessaging.requestPermission(
//         alert: true, badge: true, criticalAlert: true, sound: true);
//     _firebaseMessaging.setForegroundNotificationPresentationOptions(
//         alert: true, badge: true, sound: true);
//   }

//   //push notification listeners
//   static pushNotificationListenerInit({required BuildContext context}) async {
//      initializeLocalNotification(context);
//     ///subscribe to a topic
//     FirebaseMessaging.instance
//         .subscribeToTopic("topic_name")
//         .catchError((error) async {
//       /// Delete token for user if error code is UNREGISTERED or INVALID_ARGUMENT.
//       if (error
//           .toString()
//           .toLowerCase()
//           .contains('registration-token-not-registered')) {
//         ///delete user token
//         await FirebaseMessaging.instance.deleteToken();

//         ///send updated token to the server.
//       }
//     });

//     ///gives you the message the user taps and opens the app from terminated state
//     FirebaseMessaging.instance.getInitialMessage().then((message) async {
//       if (message != null) {
//         ///perform action here... redirect/navigate user to desired location within the app
//       }
//     });

//     ///called when app is in the foreground(when app is visible)
//     FirebaseMessaging.onMessage.listen((message) async {
//       ///perform action here... show notification prompt(s) to user
//       final notification = message.notification;
//       if (notification == null) return;
//       _localNotification.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//                 _androidChannel.id, _androidChannel.name,
//                 channelDescription: _androidChannel.description,
//                 icon: '@mipmap/ic_launcher',
//                 showWhen: false),
//           ),
//           payload: jsonEncode(message.toMap()));


//     });


//     ///called when app is opened via a push notification(app should be in background and NOT TERMINATED)
//     FirebaseMessaging.onMessageOpenedApp.listen((message) async {
//       ///perform action here... redirect/navigate user to desired location within the app

//     });

//     ///listens to token refresh
//     FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
//       ///send updated token to the server
//       // if(Platform.isAndroid)
//       //   Freshchat.setPushRegistrationToken(newToken);

//       ///perform action here
//     });
//   }

//   static initializeLocalNotification(BuildContext context) async {
//     final FlutterLocalNotificationsPlugin notificationsPlugin =
//         FlutterLocalNotificationsPlugin();

//     Future onDidReceiveLocalNotification(
//         int id, String? title, String? body, String? payload) async {
//       // display a dialog with the notification details, tap ok to go to another page
//       showDialog(
//         context: context,
//         builder: (BuildContext context) => CupertinoAlertDialog(
//           title: Text(title!),
//           content: Text(body!),
//           actions: [
//             CupertinoDialogAction(
//               isDefaultAction: true,
//               child: const Text('Ok'),
//               onPressed: () async {
//                 Navigator.of(context, rootNavigator: true).pop();
//               },
//             )
//           ],
//         ),
//       );
//     }

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: const AndroidInitializationSettings("@mipmap/ic_launcher"),
//             iOS: DarwinInitializationSettings(
//                 onDidReceiveLocalNotification: onDidReceiveLocalNotification));

//     notificationsPlugin.initialize(initializationSettings);

//     final platform = notificationsPlugin.resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>();

//     await platform?.createNotificationChannel(_androidChannel);
//   }

//   static Future<String?> getFirebaseToken()async{
//     try{
//       final token = await _firebaseMessaging.getToken();
//       return token;
//     }catch(e){
//       return '';
//     }
//   }
// }
