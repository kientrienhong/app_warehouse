abstract class CustomerDetailStorageView {
  // update view
  void updateQuantity(Map<String, int> value, double totalPrice);
  void updateLoading();
  void updateMsg(bool isError, String msg);
  // event customer
  void onClickChangeQuantity(String value, bool isIncrease);
  void onClickPayment(int idStorage);
}
