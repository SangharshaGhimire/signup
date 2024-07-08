import 'package:flutter/material.dart';
import 'package:signup/core/api_response.dart';
import 'package:signup/core/status_util.dart';
import 'package:signup/model/register_model.dart';
import 'package:signup/repo/register_service.dart';
import 'package:signup/repo/register_service_impl.dart';
import 'package:signup/ui/register.dart';

class RegisterProvider extends ChangeNotifier {
  TextEditingController eventTitle = TextEditingController();
  TextEditingController teamName = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController noOfPlayer = TextEditingController();
  TextEditingController address = TextEditingController();

  RegisterService registerService = RegisterServiceImpl();
  List<RegisterModel> userList1 = [];

  StatusUtil RegisterStatus = StatusUtil.none;
  StatusUtil DeleteStatus = StatusUtil.none;
  String? errorMessage;

  setRegisterStatus(StatusUtil value) {
    RegisterStatus = value;
    notifyListeners();
  }

  setDelete(StatusUtil value) {
    DeleteStatus = value;
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
      getRegister();
      setRegisterStatus(StatusUtil.success);
    } else if (response.status == StatusUtil.error) {
      setRegisterStatus(StatusUtil.error);
    }
  }

  Future<void> getRegister() async {
    if (RegisterStatus != StatusUtil.loading) {
      setRegisterStatus(StatusUtil.loading);
    }

    ApiResponse response = await registerService.getRegister();
    if (response.status == StatusUtil.success) {
      // userList1 = registerModelFromJson(response.data);
      userList1 = response.data;
      setRegisterStatus(StatusUtil.success);
    } else if (response.status == StatusUtil.error) {
      errorMessage = response.errorMessage;
      setRegisterStatus(StatusUtil.error);
    }
  }

  Future<void> deleteRegister(String id) async {
    if (DeleteStatus != StatusUtil.loading) {
      setDelete(StatusUtil.loading);
    }
    ApiResponse response = await registerService.deleteRegister(id);
    if (response.status == StatusUtil.success) {
      setDelete(StatusUtil.success);
    } else if (response.status == StatusUtil.error) {
      setDelete(StatusUtil.error);
    }
  }
}
