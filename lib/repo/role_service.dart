import 'package:signup/core/api_response.dart';
import 'package:signup/model/role_model.dart';

abstract class RoleService {
  Future<ApiResponse> setRole(RoleModel rolemodel);
}
