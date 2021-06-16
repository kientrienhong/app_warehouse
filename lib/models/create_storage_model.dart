import 'dart:io';

class CreateStorageModel {
  Map<String, List<File>> _allImage;
  bool _isAgree;
  bool get isAgree => this._isAgree;

  set isAgree(bool value) => this._isAgree = value;

  get allImage => this._allImage;

  set allImage(value) => this._allImage = value;
  CreateStorageModel() {
    _allImage = {
      'imageStorage': <File>[],
      'paperStorage': <File>[],
    };
    _isAgree = false;
  }
}
