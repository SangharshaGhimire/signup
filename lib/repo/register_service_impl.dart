import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup/core/api_response.dart';
import 'package:signup/core/status_util.dart';
import 'package:signup/model/register_model.dart';
import 'package:signup/provider/register_provider.dart';
import 'package:signup/repo/register_service.dart';
import 'package:signup/ui/register.dart';

class RegisterServiceImpl extends RegisterService {
  List<RegisterModel> userList1 = [];
  @override
  Future<ApiResponse> setRegister(RegisterModel register) async {
    try {
      await FirebaseFirestore.instance
          .collection("register")
          .add(register.toJson());
      return ApiResponse(status: StatusUtil.success);
    } catch (e) {
      return ApiResponse(status: StatusUtil.error);
    }
  }

  @override
  Future<ApiResponse> deleteRegister(String id) async {
    try {
      await FirebaseFirestore.instance.collection("register").doc(id).delete();
      return ApiResponse(status: StatusUtil.success);
    } catch (e) {
      return ApiResponse(status: StatusUtil.error, errorMessage: e.toString());
    }
  }

  @override
  Future<ApiResponse> getRegister() async {
    try {
      var response =
          await FirebaseFirestore.instance.collection("register").get();
      final user = response.docs;
      List<RegisterModel> user1 = [];
      if (user.isNotEmpty) {
        for (var userDetails in user) {
          RegisterModel register = RegisterModel.fromJson(userDetails.data());
          register.id = userDetails.id;
          user1.add(register);
        }
      }
      return ApiResponse(status: StatusUtil.success, data: user1);
    } catch (e) {
      return ApiResponse(status: StatusUtil.error, errorMessage: e.toString());
    }
  }
}
