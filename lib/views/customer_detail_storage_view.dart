import 'package:flutter/material.dart';

abstract class CustomerDetailStorageView {
  // update view
  void updateQuantity(Map<String, int> value, double totalPrice);
  void updateLoading();
  void updateMsg(bool isError, String msg);
  void updateDatePickUp(String newDate);
  // event customer
  void onClickChangeQuantity(String value, bool isIncrease);
  void onClickPayment(int idStorage);
  void onClickSelectDate(BuildContext context);
}
