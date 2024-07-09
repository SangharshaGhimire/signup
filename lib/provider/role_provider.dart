import 'package:flutter/material.dart';
import 'package:signup/core/api_response.dart';
import 'package:signup/core/status_util.dart';
import 'package:signup/model/role_model.dart';
import 'package:signup/repo/role_service.dart';
import 'package:signup/repo/role_service_impl.dart';

class RoleProvider extends ChangeNotifier {
  RoleService roleService = RoleServiceImpl();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firebaseToken = TextEditingController();
  String? id;

  TextEditingController role = TextEditingController();

  String? errorMessage;

  StatusUtil Rolestatus = StatusUtil.none;

  RoleStatusUtil(StatusUtil value) {
    Rolestatus = value;
    notifyListeners();
  }

  Future<void> setRole() async {
    RoleModel rolemodel = RoleModel(
      username: username.text,
      email: email.text,
      password: password.text,
      firebaseToken: firebaseToken.text,
      id: int.parse(id!),
      role: role.text,
    );
    ApiResponse response = await roleService.setRole(rolemodel);
    if (response.status == StatusUtil.success) {
      RoleStatusUtil(StatusUtil.success);
    } else if (response.status == StatusUtil.error) {
      errorMessage = response.errorMessage;
      RoleStatusUtil(StatusUtil.error);
    }
  }
}
