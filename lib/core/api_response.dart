import 'package:signup/core/status_util.dart';

class ApiResponse{
  StatusUtil?status;
  String?errorMessage;
  dynamic?data;
  ApiResponse({this.data,this.errorMessage,this.status});

}