import 'dart:convert';

import 'package:appwarehouse/api/firebase_services.dart';

import '/api/api_services.dart';
import '/models/entity/user.dart';
import '/models/login_model.dart';
import '/views/login_view.dart';

class LoginPresenter {
  LoginModel _model;
  LoginView _view;
  LoginView get view => this._view;

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
      final result = await FirebaseServices.firebaseLogin(email, password);
      print(result);
      if (result == null) {
        _view.updateViewErrorMsg('Invalid username / password');
        throw Exception('Invalid email or password');
      }
      var response = await ApiServices.logIn(result);
      response = json.encode(response.data);
      User user = User.fromJson(json.decode(response));
      print(user.jwtToken);
      _model.user = user.copyWith(idTokenFirebase: result);
      return _model.user;
    } catch (e) {
      print(e.toString());
      throw Exception('Invalid email or password');
    } finally {
      _view.updateLoading();
    }
  }
}
