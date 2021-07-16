abstract class OwnerDetailStorageView {
  void updateLoadingAddShelf();
  void updateLoadingDeleteShelf();
  void onHandleAddShelf(int idStorage);
  Future<bool> onHandleDeleteShelf(int idShelf);
  void fetchPage(int pageKey);
  void fetchFeedBack(int pageKey);
}
