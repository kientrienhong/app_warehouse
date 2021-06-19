import 'dart:io';

import 'package:app_warehouse/models/entity/user.dart';

abstract class UpdateInfoView {
  // update view
  void updateUser(User user);

  void updateFile(File file);

  void updateLoading();

  void updateMsg(String msg, bool isError);

  //click update info
  void onClickUpdateInfo(File file, User user);

  void onClickGalleryInfo();
}
