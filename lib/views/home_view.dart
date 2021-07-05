abstract class HomeView {
  // update view
  void updateSearch();
  void updateLoadingRefresh();
  void updateLoadingDeleteStorage();

  //handle search
  void onClickSearch(String search);
  Future<void> fetchPage(int pageKey, String address);
}
