
import 'package:expence_tracker/pages/history_screen.dart';
import 'package:expence_tracker/pages/login/login_bloc.dart';
import 'package:expence_tracker/pages/login/login_page.dart';
import 'package:expence_tracker/pages/registation/regisitration_bloc.dart';
import 'package:expence_tracker/pages/registation/regisitration_screen.dart';
import 'package:expence_tracker/pages/splash_page.dart';
import 'package:expence_tracker/themes/theme_provider.dart';
import 'package:expence_tracker/utils/AppRoutes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'models/profile_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  tz.initializeTimeZones();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider<ExpenseProvider>(
          create: (_) => ExpenseProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserDetailsDao _userDetailsDao = UserDetailsDao();
  AndroidNotificationChannel? channel;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    getPermission();
    listenFirebase();
    initializeLocalNotifications();
    scheduleDailyNotification();
  }
  void initializeLocalNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void scheduleDailyNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'daily_reminder_channel_id', 'Daily Reminders',
        channelDescription: 'Channel for daily reminder notifications',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Daily Expense Reminder',
        'Don\'t forget to record your expenses today!',
        _nextInstanceOfTenAM(),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  tz.TZDateTime _nextInstanceOfTenAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      routes: _registerRoutes(context),
      initialRoute: AppRoutes.splash,
    );
  }

  Map<String, WidgetBuilder> _registerRoutes(BuildContext context) {
    return <String, WidgetBuilder>{
      AppRoutes.splash: (context) => SplashPage(),
      AppRoutes.login: (context) => _buildLoginBloc(context),
      AppRoutes.register: (context) => _buildRegister(context),
    };
  }

  BlocProvider<LoginBloc> _buildLoginBloc(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(userDetailsDao:_userDetailsDao),
      child: const LoginPage(),
    );
  }
  BlocProvider<RegistrationBloc> _buildRegister(BuildContext context) {
    return BlocProvider<RegistrationBloc>(
      create: (context) => RegistrationBloc(_userDetailsDao),
      child:  RegistrationScreen(),
    );
  }



  listenFirebase() async {
    await Firebase.initializeApp();
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description:
        'This channel is used for important notifications.',
        importance: Importance.high,
      );
    }
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel!);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showFlutterNotification(message);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    });

  }

  void showFlutterNotification(RemoteMessage message) {

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    BigTextStyleInformation bigTextStyleInformation =
    BigTextStyleInformation(notification!.body.toString());
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(channel!.id, channel!.name,
              channelDescription: channel!.description,
              color: Colors.blueAccent,
              enableVibration: true,
              playSound: true,
              channelShowBadge: true,
              styleInformation: bigTextStyleInformation),
        ),
      );
    }
  }
  Future<void> getPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }



}





