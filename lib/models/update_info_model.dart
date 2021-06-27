import 'dart:io';

import '/models/entity/user.dart';

class UpdateInfoModel {
  User user;
  File file;
  bool isLoading;
  bool isError;
  String msg;
  UpdateInfoModel(User user) {
    user = user;
    file = null;
    isLoading = false;
    msg = '';
    isError = false;
  }
}
