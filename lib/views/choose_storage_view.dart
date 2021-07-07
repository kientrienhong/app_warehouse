import 'package:appwarehouse/models/entity/storage.dart';

abstract class ChooseStorageView {
  void updateViewCurrentStorage(Storage storage);

  void onClickStorage(int index);
  void fetchStorage(int pageKey);
  void fetchShelf(int pageKey, int idStorage);
}
