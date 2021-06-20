import 'dart:convert';

import 'package:app_warehouse/api/api_services.dart';
import 'package:app_warehouse/helpers/validator.dart';
import 'package:app_warehouse/models/sign_up_model.dart';
import 'package:app_warehouse/views/sign_up_view.dart';

class SignUpPresenter {
  SignUpView _view;
  SignUpModel _model;
  get view => this._view;

  set view(value) => this._view = value;

  get model => this._model;

  SignUpPresenter() {
    _model = SignUpModel();
  }

  String validate(String role, String email, String password,
      String confirmPassword, String name, String phone, String address) {
    String result = '';
    List<String> invalidMsg = [];
    if (email.isEmpty) {
      invalidMsg.add('Email');
    }

    if (password.isEmpty) {
      invalidMsg.add('Password');
    }

    if (confirmPassword.isEmpty) {
      invalidMsg.add('Confirm password');
    }

    if (name.isEmpty) {
      invalidMsg.add('Name');
    }

    if (phone.isEmpty) {
      invalidMsg.add('Phone');
    }

    if (address.isEmpty) {
      invalidMsg.add('Address');
    }

    if (invalidMsg.length > 0) {
      result = invalidMsg.join(', ');
      result += ' must be filled\n';
    }
    if (confirmPassword.isNotEmpty && password.isNotEmpty) {
      if (confirmPassword != password) {
        result += 'New passowrd must be match with confirm password';
      }
    }

    if (Validator.checkPhoneNumber(phone) ==
        'Please enter valid mobile number') {
      result += 'Please enter valid mobile number';
    }

    if (role == null) {
      result += 'Please choose role';
    }
    return result;
  }

  Future<bool> onHandleSignUp(String role, String email, String password,
      String confirmPassword, String name, String phone, String address) async {
    _view.updateLoading();
    try {
      String validateMsg = validate(
          role, email, password, confirmPassword, name, phone, address);
      if (validateMsg != '') {
        _view.updateMsg(validateMsg, true);
        return false;
      }

      var response = await ApiServices.signUp(
          role, email, password, confirmPassword, name, phone, address);
      // print(response);
      response = json.encode(response.data);
      Map<String, dynamic> result = json.decode(response);
      if (result['error'] != null) {
        _view.updateMsg(result['error']['message'], true);
        return false;
      } else {
        _view.updateMsg('Change sucessfull', false);
        return true;
      }
    } catch (e) {
      _view.updateMsg('Email Existed', true);
      throw Exception(e);
    } finally {
      _view.updateLoading();
    }
  }
}
