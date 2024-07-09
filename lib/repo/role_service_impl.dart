import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup/core/api.dart';
import 'package:signup/core/api_const.dart';
import 'package:signup/core/api_response.dart';
import 'package:signup/core/status_util.dart';
import 'package:signup/model/role_model.dart';
import 'package:signup/repo/role_service.dart';

class RoleServiceImpl extends RoleService {
  Api api = Api();
  @override
  Future<ApiResponse> setRole(RoleModel rolemodel) async {
    ApiResponse response =
        await api.post(Apiconst.baseUrl + Apiconst.roleApi, rolemodel.toJson());
    return response;
  }
}
