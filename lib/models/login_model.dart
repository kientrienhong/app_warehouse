import 'package:app_warehouse/models/entity/user.dart';

class LoginModel {
  bool _isDisableLogin;
  String _errorMsg;
  bool _isLoading;
  User _user;

  LoginModel() {
    _isDisableLogin = true;
    _errorMsg = '';
    _isLoading = false;
    _user = User();
  }
  get user => this._user;

  set user(value) => this._user = value;

  bool get isLoading => this._isLoading;

  set isLoading(bool value) => this._isLoading = value;

  String get errorMsg => this._errorMsg;

  set errorMsg(String value) => this._errorMsg = value;

  get isDisableLogin => this._isDisableLogin;

  set isDisableLogin(value) => this._isDisableLogin = value;
}
