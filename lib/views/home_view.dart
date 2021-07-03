abstract class HomeView {
  // update view
  void updateSearch();
  //handle search
  void onClickSearch(String search);
  Future<void> fetchPage(int pageKey, String address);
}
