import 'dart:io';

import '/models/entity/user.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class UpdateInfoView {
  // update view
  void updateUser(User user);

  void updateFile(File file);

  void updateLoading();

  void updateMsg(String msg, bool isError);

  //click update info
  void onClickUpdateInfo(File file, User user, UploadTask task);

  void onClickGalleryInfo();
}
