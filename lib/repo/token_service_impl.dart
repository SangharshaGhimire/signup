import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:signup/core/api.dart';
import 'package:signup/core/api_const.dart';
import 'package:signup/core/api_response.dart';
import 'package:signup/model/token.dart';
import 'package:signup/repo/token_service.dart';

class TokenServiceImpl extends TokenService {
  Api api = Api();
  @override
  Future<ApiResponse> setToken(Token token) async {
    ApiResponse response =
        await api.post(Apiconst.baseUrl + Apiconst.roleApi, token.toJson());
    return response;
    // FirebaseMessaging messaging = FirebaseMessaging.instance;

    // String? token = await messaging.getToken();

    // var json = {
    //   // "username": "john_doe",
    //   // "firstname": "John",
    //   // "lastname": "Doe",
    //   // "gender": "Male",
    //   // "email": "ram@example.com",
    //   // "password": "securepassword123",
    //   // "profilePic": "profile-pic-url.jpg",
    //   // "panNo": "ABCDE1234F",
    //   // "registrationNo": "1234567890",
    //   // "role": "USER",
    //   // "firebaseToken": token

    //   {
    //     "user_id": 1,
    //     "password": "password123",
    //     "email": "example@example.com",
    //     "firebaseToken": "firebaseToken123",
    //     "address": {
    //       "address_id": 1,
    //       "streetAddress": "123 Main St",
    //       "zip_code": "12345",
    //       "state": "CA",
    //       "city": "Los Angeles"
    //     }
    //   }
    // };
  }
}
