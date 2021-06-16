import 'dart:io';

abstract class CreateStorageView {
  // update view
  void updateGridView(String typeList, List<File> listFile);
  void updateStatusButton(bool isAgree);
  // handle event
  void onClickAddCameraImage(String typeList);
  void onClickAddGalleryImage(String typeList);
}
