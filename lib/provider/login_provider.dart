import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup/core/api_response.dart';
import 'package:signup/core/status_util.dart';
import 'package:signup/model/Signup_model.dart';

import 'package:signup/repo/login_service.dart';
import 'package:signup/repo/login_service_impl.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController emailTextField = TextEditingController();
  TextEditingController passwordTextField = TextEditingController();

  String? errorMessage;
  bool isUserCheckStatus = false;
  bool isChecked = false;
  LoginService loginService = LoginServiceImpl();

  StatusUtil LoginStatus = StatusUtil.none;

  LogininStatusUtil(StatusUtil value) {
    LoginStatus = value;
    notifyListeners();
  }

  CheckStatus(value) {
    isChecked = value;
    notifyListeners();
  }

  Future<void> getSignup() async {
    if (LoginStatus != StatusUtil.loading) {
      LogininStatusUtil(StatusUtil.loading);
    }

    Signup signup =
        Signup(email: emailTextField.text, password: passwordTextField.text);
    ApiResponse response = await loginService.getSignup(signup);
    if (response.status == StatusUtil.success) {
      isUserCheckStatus = response.data;

      LogininStatusUtil(StatusUtil.success);
    } else if (response.status == StatusUtil.error) {
      errorMessage = response.errorMessage;

      LogininStatusUtil(StatusUtil.error);
    }
  }

  saveValueToSharedPreference({String? email}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email!);
    print(email);
    await prefs.setBool('isLogin', true);
    notifyListeners();
  }

  RememberMe(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value) {
      await prefs.setBool('isRemember', value);
      await prefs.setString("email", emailTextField.text);
      await prefs.setString("password", passwordTextField.text);
    } else {
      await prefs.remove("isRemember");
      await prefs.remove("email");
      await prefs.remove("password");
    }
  }

  clearData() {
    emailTextField.text = "";

    passwordTextField.text = "";
    notifyListeners();
  }
}
