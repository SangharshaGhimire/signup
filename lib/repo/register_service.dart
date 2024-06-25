import 'package:signup/core/api_response.dart';
import 'package:signup/model/register_model.dart';
import 'package:signup/ui/register.dart';

abstract class RegisterService {
  Future<ApiResponse> setRegister(RegisterModel register);
}
