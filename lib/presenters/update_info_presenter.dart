import 'dart:convert';
import 'dart:io';

import 'package:app_warehouse/api/api_services.dart';
import 'package:app_warehouse/helpers/validator.dart';
import 'package:app_warehouse/models/entity/user.dart';
import 'package:app_warehouse/models/update_info_model.dart';
import 'package:app_warehouse/views/update_info_view.dart';

class UpdateInfoPresenter {
  UpdateInfoModel _model;
  UpdateInfoView _view;
  get model => this._model;

  get view => this._view;

  set view(value) => this._view = value;

  UpdateInfoPresenter(User user) {
    _model = UpdateInfoModel(user);
  }

  String validate(User user) {
    String result = '';
    List<String> invalidMsg = [];
    if (user.address.isEmpty) {
      invalidMsg.add('Address');
    }

    if (user.name.isEmpty) {
      invalidMsg.add('Name');
    }
    String validateNumber = Validator.checkPhoneNumber(user.phone);
    if (validateNumber == 'Phone number') {
      invalidMsg.add('Phone');
    } else if (validateNumber == 'Please enter valid mobile number') {
      if (invalidMsg.length > 0) {
        result = invalidMsg.join(', ');
        result += ' must be filled\n';
      }

      result += validateNumber;
      return result;
    }
    if (invalidMsg.length > 0) {
      result = invalidMsg.join(', ');
      result += ' must be filled';
    }
    return result;
  }

  Future<User> onHandleUpdaetInfo(User user, String jwt, File file) async {
    try {
      view.updateLoading();
      String invalidMsg = validate(user);
      if (invalidMsg.isEmpty) {
        var response = await ApiServices.updateInfo(
            user.name, user.address, user.phone, jwt);
        response = json.encode(response.data);
        Map<String, dynamic> result = json.decode(response);
        User newUser = User(
            address: result['address'],
            email: result['email'],
            jwtToken: jwt,
            name: result['name'],
            phone: result['phone'],
            role: UserRole.owner);
        _view.updateUser(user);
        view.updateLoading();
        _view.updateMsg('Update sucessful', false);
        return newUser;
      } else {
        _view.updateLoading();
        _view.updateMsg(invalidMsg, true);
        return null;
      }
    } catch (e) {
      view.updateLoading();

      throw Exception('Update failed');
    }
  }

  onHandleAddImage(File file) {
    _model.file = file;
    _view.updateFile(file);
  }
}
