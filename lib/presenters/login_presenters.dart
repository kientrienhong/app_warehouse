import 'dart:convert';

import 'package:app_warehouse/api/api_services.dart';
import 'package:app_warehouse/models/entity/user.dart';
import 'package:app_warehouse/models/login_model.dart';
import 'package:app_warehouse/views/login_view.dart';

class LoginPresenter {
  LoginModel _model;
  LoginView _view;
  LoginView get view => this._view;

  // set view(LoginView value) => this._view = value;
  setView(LoginView value) {
    _view = value;
  }

  LoginModel get model => this._model;

  LoginPresenter() {
    _model = LoginModel();
  }

  void handleOnChangeInput(String email, String password) {
    _view.updateViewStatusButton(email, password);
  }

  Future<User> handleSignIn(String email, String password) async {
    _view.updateLoading();
    try {
      var response = await ApiServices.logIn(email, password);
      response = json.encode(response.data);
      _model.user = User.fromJson(json.decode(response));
      return _model.user;
    } catch (e) {
      print(e.toString());
      throw Exception('Invalid email or password');
    } finally {
      _view.updateLoading();
    }
  }
}
