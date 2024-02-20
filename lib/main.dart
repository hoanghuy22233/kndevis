import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kndevis/splash_screen.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  if (flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
  AndroidFlutterLocalNotificationsPlugin>() !=
  null) {
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
  AndroidFlutterLocalNotificationsPlugin>()!
      .requestPermission();
  }

  var initializationSettings;
  if (Platform.isAndroid) {
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel', 'xxxx',
  importance: Importance.max);
  var initializationSettingsAndroid =
  const AndroidInitializationSettings("@mipmap/ic_launcher");
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
  AndroidFlutterLocalNotificationsPlugin>()!
      .createNotificationChannel(channel);

  initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);
  } else {
  var initializationSettingsIOS = const DarwinInitializationSettings();
  initializationSettings =
  InitializationSettings(iOS: initializationSettingsIOS);
  }
  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  RemoteNotification notification = message.notification!;
  print('notificationnnnnnnn ${notification.title}');

  if (Platform.isAndroid) {
  AndroidNotification androidNotification =
  message.notification!.android!;
  if (androidNotification != null) {
  var androidPlatformChannelSpecifics =
  const AndroidNotificationDetails(
  'high_importance_channel', 'xxxx',
  importance: Importance.max,
  playSound: true,
  showProgress: true,
  priority: Priority.high,
  ticker: 'test ticker');

  var iOSChannelSpecifics = const DarwinNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
  android: androidPlatformChannelSpecifics,
  iOS: iOSChannelSpecifics);
  // Vibration.vibrate(duration: 1000, amplitude: 128);
  await flutterLocalNotificationsPlugin.show(0, notification.title,
  notification.body, platformChannelSpecifics,
  payload: 'test');
  }
  } else if (Platform.isIOS) {
  var iOSChannelSpecifics = const DarwinNotificationDetails();
  var platformChannelSpecifics =
  NotificationDetails(iOS: iOSChannelSpecifics);
  // Vibration.vibrate(duration: 1000, amplitude: 128);
  await flutterLocalNotificationsPlugin.show(
  0, notification.title, notification.body, platformChannelSpecifics,
  payload: 'test');
  }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}


