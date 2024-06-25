import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup/core/api_response.dart';
import 'package:signup/core/status_util.dart';
import 'package:signup/model/register_model.dart';
import 'package:signup/provider/register_provider.dart';
import 'package:signup/repo/register_service.dart';
import 'package:signup/ui/register.dart';

class RegisterServiceImpl extends RegisterService {
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
}
