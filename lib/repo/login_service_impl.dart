import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:signup/core/api_response.dart';
import 'package:signup/core/status_util.dart';
import 'package:signup/model/Signup_model.dart';

import 'package:signup/repo/login_service.dart';

class LoginServiceImpl extends LoginService {
  @override
  Future<ApiResponse> getSignup(Signup signup) async {
    bool isUserExists = false;

    try {
      await FirebaseFirestore.instance
          .collection("signup")
          .where("email", isEqualTo: signup.email)
          .where("password", isEqualTo: signup.password)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          isUserExists = true;
        }
      });
      return ApiResponse(status: StatusUtil.success, data: isUserExists);
    } catch (e) {
      return ApiResponse(status: StatusUtil.error, errorMessage: e.toString());
    }
  }
}
