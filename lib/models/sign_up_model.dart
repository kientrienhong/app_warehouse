class SignUpModel {
  bool _isLoading;
  String _errorMsg;
  bool _isError;
  get isLoading => this._isLoading;

  set isLoading(value) => this._isLoading = value;

  get errorMsg => this._errorMsg;

  set errorMsg(value) => this._errorMsg = value;

  get isError => this._isError;

  set isError(value) => this._isError = value;
  SignUpModel() {
    _isError = false;
    _isLoading = false;
    _errorMsg = '';
  }
}
