import 'dart:io';

abstract class CreateStorageView {
  // update view
  void updateGridView(String typeList, List<File> listFile);
  void updateStatusButton(bool isAgree);
  // handle event
  void onClickAddGalleryImage(String typeList);
  void onClickEditGalleryImage(String typeList, int index);
  void onClickDeleteGalleryImage(String typeList, int index);
}
