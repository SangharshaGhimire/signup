import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup/firebase_options.dart';
import 'package:signup/provider/login_provider.dart';
import 'package:signup/provider/register_provider.dart';
import 'package:signup/provider/role_provider.dart';
import 'package:signup/provider/signup_Provider.dart';
import 'package:signup/provider/token_provider.dart';
import 'package:signup/ui/loginui.dart';
import 'package:signup/ui/mobilenumber.dart';
import 'package:signup/ui/page.dart';
import 'package:signup/ui/register.dart';
import 'package:signup/ui/router_generator.dart';
import 'package:signup/ui/routs.dart';
import 'package:signup/ui/token.dart';
import 'package:signup/ui/ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUserLoggedIn = false;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final GlobalKey<NavigatorState> firebaseNavigatorKey =
      GlobalKey<NavigatorState>();

  void notificationSetting() async {
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

  getFCMToken() async {
    String? token = await messaging.getToken();
    print("FCN token:$token");
  }

  void initState() {
    notificationSetting();
    // listenBackgroundMessage();
    init();

    readValueFromSharedPreference();
    listenForgroundMessage();
    getFCMToken();
    super.initState();
  }

  listenForgroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print('Message data: ${message.data}');
      showNotificationAndroid(
          message.notification!.title!, message.notification!.body!);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      firebaseNavigatorKey.currentState?.pushNamed(Routs.notificationRouts);
    });
  }

  Future<void> init() async {
    // Initialize native android notification
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Initialize native Ios Notifications
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (value) {
      firebaseNavigatorKey.currentState?.pushNamed(Routs.notificationRouts);
    });
  }

  void showNotificationAndroid(String title, String value) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'Channel Name',
            channelDescription: 'Channel Description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    int notification_id = 1;
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        notification_id, title, value, notificationDetails,
        payload: 'Not present');
  }

  // listenBackgroundMessage() {
  //   Future<void> _firebaseMessagingBackgroundHandler(
  //       RemoteMessage message) async {
  //     await Firebase.initializeApp();

  //     print("Handling a background message: ${message.messageId}");
  //   }

  //   void main() {
  //     FirebaseMessaging.onBackgroundMessage(
  //         _firebaseMessagingBackgroundHandler);
  //     runApp(MyApp());
  //   }
  // }

  @override

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignupProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
        ChangeNotifierProvider(create: (context) => RoleProvider()),
        ChangeNotifierProvider(create: (context) => TokenProvider()),
      ],
      child: MaterialApp(
        navigatorKey: firebaseNavigatorKey,
        onGenerateRoute: RoutGenerator.generateRoute,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: isUserLoggedIn ? Mainpages() : LoginUI(),
        home: MobileNumber(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  readValueFromSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isUserLoggedIn = prefs.getBool('isLogin') ?? false;

    setState(() {
      isUserLoggedIn;
    });
  }
}
