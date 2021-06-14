abstract class CustomerDetailStorageView {
  // update view
  void updateQuantity(Map<String, int> value, double totalPrice);

  // event customer
  void onClickChangeQuantity(String value, bool isIncrease);
}
