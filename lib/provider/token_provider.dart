import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:signup/core/api_response.dart';
import 'package:signup/core/status_util.dart';
import 'package:signup/model/token.dart';
import 'package:signup/repo/token_service.dart';
import 'package:signup/repo/token_service_impl.dart';

class TokenProvider extends ChangeNotifier {
  TokenService tokenService = TokenServiceImpl();

  StatusUtil statusUtil = StatusUtil.none;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController username = TextEditingController();
  TextEditingController firebaseToken = TextEditingController();
  String? id;

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  TextEditingController role = TextEditingController();

  String? errorMessage;

  setStatusUtil(StatusUtil value) {
    statusUtil = value;
    notifyListeners();
  }

  Future<void> setToken() async {
    String? firebaseToken = await messaging.getToken();

    Token tokens = Token(
        email: email.text,
        password: password.text,
        firebaseToken: firebaseToken,
        username: username.text,
        role: role.text);

    ApiResponse response = await tokenService.setToken(tokens);
    if (response.status == StatusUtil.success) {
      setStatusUtil(StatusUtil.success);
    } else if (response.status == StatusUtil.error) {
      errorMessage = response.errorMessage;
      setStatusUtil(StatusUtil.error);
    }
  }
}
