import 'dart:io';

class CreateStorageModel {
  Map<String, List<dynamic>> _allImage;
  bool _isAgree;
  bool _isLoading;
  bool _isError;
  String _msg;
  get isLoading => this._isLoading;

  set isLoading(value) => this._isLoading = value;

  get isError => this._isError;

  set isError(value) => this._isError = value;

  get msg => this._msg;

  set msg(value) => this._msg = value;

  bool get isAgree => this._isAgree;

  set isAgree(bool value) => this._isAgree = value;

  get allImage => this._allImage;

  set allImage(value) => this._allImage = value;
  CreateStorageModel() {
    _isLoading = false;
    _isError = false;
    _msg = '';
    _allImage = {
      'imageStorage': <dynamic>[],
      'paperStorage': <dynamic>[],
    };
    _isAgree = false;
  }
}
