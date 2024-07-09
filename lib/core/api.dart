import 'dart:io';

import 'package:dio/dio.dart';
import 'package:signup/core/api_response.dart';
import 'package:signup/core/status_util.dart';

class Api {
  Dio dio = Dio();
  Api() {
    dio.options.headers['content-Type'] = "application/json";
  }
  post(String url, var data) async {
    try {
      Response response = await dio.post(url, data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(status: StatusUtil.success, data: response.data);
      } else {
        return ApiResponse(
            status: StatusUtil.error, errorMessage: "Bad Request");
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return ApiResponse(
            status: StatusUtil.error, errorMessage: "Bad Request");
      } else if (e.error is SocketException) {
        return ApiResponse(
            status: StatusUtil.error, errorMessage: "No Internet Connection");
      } else {
        return ApiResponse(
            status: StatusUtil.error, errorMessage: e.toString());
      }
    }
  }

  get(String url) async {
    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(status: StatusUtil.success, data: response.data);
      } else {
        return ApiResponse(
            status: StatusUtil.error, errorMessage: "Bad Request");
      }
    } catch (e) {
      return ApiResponse(status: StatusUtil.error, errorMessage: e.toString());
    }
  }
}
