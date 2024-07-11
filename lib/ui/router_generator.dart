import 'package:flutter/material.dart';
import 'package:signup/ui/loginui.dart';
import 'package:signup/ui/routs.dart';
import 'package:signup/ui/setting.dart';

class RoutGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routs.loginRouts:
        return MaterialPageRoute(builder: (_) => LoginUI());

      case Routs.notificationRouts:
        return MaterialPageRoute(builder: (_) => Setting());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Text("No Route found"),
                ));
    }
  }
}
