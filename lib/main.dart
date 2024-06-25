import 'package:firebase_core/firebase_core.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUserLoggedIn = false;
  @override
  void initState() {
    readValueFromSharedPreference();
    super.initState();
  }

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
        // home: Register(),
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
