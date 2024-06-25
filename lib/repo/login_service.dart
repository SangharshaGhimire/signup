import 'package:signup/core/api_response.dart';
import 'package:signup/model/Signup_model.dart';


abstract class LoginService{
  Future<ApiResponse>getSignup(Signup signup);
}