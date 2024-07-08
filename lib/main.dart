import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup/firebase_options.dart';
import 'package:signup/provider/login_provider.dart';
import 'package:signup/provider/register_provider.dart';
import 'package:signup/provider/signup_Provider.dart';

import 'package:signup/ui/loginui.dart';
import 'package:signup/ui/page.dart';
import 'package:signup/ui/register.dart';
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

    readValueFromSharedPreference();
    listenForgroundMessage();
    getFCMToken();
    super.initState();
  }

  listenForgroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message data: ${message.data}');
    });
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: isUserLoggedIn ? Mainpages() : LoginUI(),
        //home: Register(),
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
