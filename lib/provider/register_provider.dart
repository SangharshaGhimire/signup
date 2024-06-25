import 'package:flutter/material.dart';
import 'package:signup/core/api_response.dart';
import 'package:signup/core/status_util.dart';
import 'package:signup/model/register_model.dart';
import 'package:signup/repo/register_service.dart';
import 'package:signup/repo/register_service_impl.dart';

class RegisterProvider extends ChangeNotifier {
  TextEditingController eventTitle = TextEditingController();
  TextEditingController teamName = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController noOfPlayer = TextEditingController();
  TextEditingController address = TextEditingController();

  RegisterService registerService = RegisterServiceImpl();

  StatusUtil RegisterStatus = StatusUtil.none;
  String? errorMessage;

  setRegisterStatus(StatusUtil value) {
    RegisterStatus = value;
    notifyListeners();
  }

  Future<void> setRegister() async {
    if (RegisterStatus != StatusUtil.loading) {
      setRegisterStatus(StatusUtil.loading);
    }
    RegisterModel register = RegisterModel(
      teamName: teamName.text,
      eventTitle: eventTitle.text,
      contact: contact.text,
      noOfPlayers: int.parse(
        noOfPlayer.text,
      ),
      address: address.text,
    );
    ApiResponse response = await registerService.setRegister(register);

    if (response.status == StatusUtil.success) {
      setRegisterStatus(StatusUtil.success);
    } else if (response.status == StatusUtil.error) {
      setRegisterStatus(StatusUtil.error);
    }
  }
}
