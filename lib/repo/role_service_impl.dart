import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String? token = await messaging.getToken();

    var json = {
      "username": "john_doe",
      "firstname": "John",
      "lastname": "Doe",
      "gender": "Male",
      "email": "ram@example.com",
      "password": "securepassword123",
      "profilePic": "profile-pic-url.jpg",
      "panNo": "ABCDE1234F",
      "registrationNo": "1234567890",
      "role": "USER",
      "firebaseToken": token
    };

    ApiResponse response =
        await api.post(Apiconst.baseUrl + Apiconst.roleApi, rolemodel.toJson());
    return response;
  }
}
