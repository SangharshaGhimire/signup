import 'package:signup/core/api_response.dart';
import 'package:signup/model/token.dart';

abstract class TokenService {
  Future<ApiResponse> setToken(Token token);
}
