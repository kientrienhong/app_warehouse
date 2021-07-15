abstract class HomeView {
  // update view
  void updateSearch();
  void updateLoadingRefresh();
  void updateLoadingDeleteStorage();

  //handle search
  void onClickSearch(int pageKey, String search);
  Future<void> fetchPage(int pageKey, String address);
  void onClickChangeDropDown(String value);
}
