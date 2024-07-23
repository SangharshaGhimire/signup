import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup/core/api_response.dart';
import 'package:signup/core/status_util.dart';
import 'package:signup/model/Signup_model.dart';
import 'package:signup/repo/signup_service.dart';
import 'package:signup/repo/signup_service_impl.dart';

class SignupProvider extends ChangeNotifier {
  SignupService signupService = SignupServiceImpl();
  // String? name, email, password, contactNumber;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  TextEditingController id = TextEditingController();

  String? errorMessage;
  String? idd;
  List<Signup> userList = [];
  Signup? user;
  StatusUtil SignupStatus = StatusUtil.none;
  StatusUtil DeleteStatus = StatusUtil.none;
  StatusUtil EditStatus = StatusUtil.none;
  StatusUtil ShowUser = StatusUtil.none;

  SignupStatusUtil(StatusUtil value) {
    SignupStatus = value;
    notifyListeners();
  }

  setDelete(StatusUtil value) {
    DeleteStatus = value;
    notifyListeners();
  }

  setId(String? id) {
    idd = id;
  }

  setEdit(StatusUtil value) {
    EditStatus = value;
    notifyListeners();
  }

  setUser(StatusUtil value) {
    ShowUser = value;
    notifyListeners();
  }

  Future<void> setSignup() async {
    if (idd == null) {
      if (SignupStatus != StatusUtil.loading) {
        SignupStatusUtil(StatusUtil.loading);
      }
      Signup signup = Signup(
          name: name.text,
          contactNumber: contactNumber.text,
          email: email.text,
          password: password.text);
      ApiResponse response = await signupService.setSignup(signup);
      if (response.status == StatusUtil.success) {
        SignupStatusUtil(StatusUtil.success);
      } else if (response.status == StatusUtil.error) {
        errorMessage = response.errorMessage;
        SignupStatusUtil(StatusUtil.error);
      }
    } else {
      if (EditStatus != StatusUtil.loading) {
        setEdit(StatusUtil.loading);
      }
      Signup signup = Signup(
          name: name.text,
          contactNumber: contactNumber.text,
          email: email.text,
          id: idd,
          password: password.text);
      ApiResponse response = await signupService.setSignup(signup);
      if (response.status == StatusUtil.success) {
        setEdit(StatusUtil.success);
      } else if (response.status == StatusUtil.error) {
        errorMessage = response.errorMessage;
        setEdit(StatusUtil.error);
      }
    }
  }

  Future<void> getSignup() async {
    if (SignupStatus != StatusUtil.loading) {
      SignupStatusUtil(StatusUtil.loading);
    }

    ApiResponse response = await signupService.getSignup();
    if (response.status == StatusUtil.success) {
      userList = response.data;
      SignupStatusUtil(StatusUtil.success);
    } else if (response.status == StatusUtil.error) {
      errorMessage = response.errorMessage;
      SignupStatusUtil(StatusUtil.error);
    }
  }

  Future<void> deleteUser(String id) async {
    if (DeleteStatus != StatusUtil.loading) {
      setDelete(StatusUtil.loading);
    }
    ApiResponse response = await signupService.deleteUser(id);
    if (response.status == StatusUtil.success) {
      setDelete(StatusUtil.success);
    } else if (response.status == StatusUtil.error) {
      setDelete(StatusUtil.error);
    }
  }

  Future<void> getUser(String email) async {
    if (ShowUser != StatusUtil.loading) {
      setUser(StatusUtil.loading);
    }
    ApiResponse response = await signupService.getUser(email);
    if (response.status == StatusUtil.success) {
      setUser(StatusUtil.success);
      user = response.data;
      print(user);
    } else if (response.status == StatusUtil.error) {
      setUser(StatusUtil.error);
    }
  }

  String? savedEmail;
  getValueToSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    savedEmail = prefs.getString('email');
    notifyListeners();
  }
}
