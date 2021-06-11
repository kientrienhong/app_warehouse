class LoginModel {
  String _username;
  String _password;
  bool _isDisableLogin;
  String _errorMsg;

  LoginModel() {
    this._username = '';
    this._password = '';
    _isDisableLogin = true;
    _errorMsg = '';
  }

  String get errorMsg => this._errorMsg;

  set errorMsg(String value) => this._errorMsg = value;

  get username => this._username;

  set username(value) => this._username = value;

  get password => this._password;

  set password(value) => this._password = value;

  get isDisableLogin => this._isDisableLogin;

  set isDisableLogin(value) => this._isDisableLogin = value;
}
