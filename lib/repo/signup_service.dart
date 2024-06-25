import 'package:signup/core/api_response.dart';
import 'package:signup/model/Signup_model.dart';

abstract class SignupService {
  Future<ApiResponse> setSignup(Signup signup);
  Future<ApiResponse> getSignup();
  Future<ApiResponse> deleteUser(String id);
}
