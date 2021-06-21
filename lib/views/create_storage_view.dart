import 'dart:io';

abstract class CreateStorageView {
  // update view
  void updateGridView(String typeList, List<File> listFile);
  void updateStatusButton(bool isAgree);
  void updateLoading();
  void updateMsg(String msg, bool isError);
  // handle event
  void onClickAddGalleryImage(String typeList);
  void onClickEditGalleryImage(String typeList, int index);
  void onClickDeleteGalleryImage(String typeList, int index);
  void onClickCreateStorage(String name, String address, String description,
      String amountShelves, String priceSmallBox, String priceBigBox);
}
