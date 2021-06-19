class ChangePasswordModel {
  bool _isError;
  String _msg;
  bool _isLoading;

  get isLoading => this._isLoading;

  set isLoading(value) => this._isLoading = value;
  get isError => this._isError;

  set isError(value) => this._isError = value;

  get msg => this._msg;

  set msg(value) => this._msg = value;

  ChangePasswordModel() {
    _isError = false;
    _msg = '';
    _isLoading = false;
  }
}
