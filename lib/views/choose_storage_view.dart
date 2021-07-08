import 'package:appwarehouse/models/entity/storage.dart';

abstract class ChooseStorageView {
  void updateViewCurrentStorage(Storage storage);
  void updateImportedLoading();
  void updateMsg(String msg, bool isError);
  void onClickStorage(int index);
  void onClickSubmitImportBox();
  void fetchStorage(int pageKey);
  void fetchShelf(int pageKey, int idStorage);
}
