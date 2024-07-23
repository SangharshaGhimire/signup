import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:signup/core/api_response.dart';
import 'package:signup/core/status_util.dart';
import 'package:signup/model/Signup_model.dart';
import 'package:signup/repo/signup_service.dart';
import 'package:signup/ui/helper.dart';

class SignupServiceImpl extends SignupService {
  List<Signup> userList = [];

  @override
  Future<ApiResponse> setSignup(Signup signup) async {
    try {
      if (signup.id == null) {
        await FirebaseFirestore.instance
            .collection("signup")
            .add(signup.toJson());
      } else {
        await FirebaseFirestore.instance
            .collection("signup")
            .doc(signup.id)
            .update(signup.toJson());
      }
      return ApiResponse(status: StatusUtil.success);
    } catch (e) {
      return ApiResponse(status: StatusUtil.error, errorMessage: e.toString());
    }
  }

  @override
  Future<ApiResponse> getSignup() async {
    try {
      var response =
          await FirebaseFirestore.instance.collection("signup").get();
      final user = response.docs;
      List<Signup> user1 = [];
      if (user.isNotEmpty) {
        for (var userDetails in user) {
          Signup signup = Signup.fromJson(userDetails.data());
          signup.id = userDetails.id;
          user1.add(signup);
        }
      }
      return ApiResponse(status: StatusUtil.success, data: user1);
    } catch (e) {
      return ApiResponse(status: StatusUtil.error, errorMessage: e.toString());
    }
  }

  @override
  Future<ApiResponse> deleteUser(String id) async {
    try {
      await FirebaseFirestore.instance.collection("signup").doc(id).delete();
      return ApiResponse(status: StatusUtil.success);
    } catch (e) {
      return ApiResponse(status: StatusUtil.error, errorMessage: e.toString());
    }
  }

  Future<ApiResponse> getUser(String email) async {
    try {
      var response = await FirebaseFirestore.instance
          .collection("signup")
          .where("email", isEqualTo: email)
          .get();

      if (response.docs.isNotEmpty) {
        final doc = response.docs.first;
        final user = Signup.fromMap(doc.data(), doc.id);
        return ApiResponse(status: StatusUtil.success, data: user);
      } else {
        return ApiResponse(
            status: StatusUtil.error, errorMessage: "User not found");
      }
    } catch (e) {
      return ApiResponse(status: StatusUtil.error, errorMessage: e.toString());
    }
  }
}
