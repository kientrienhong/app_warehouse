import 'package:appwarehouse/models/entity/box.dart';

abstract class ShelfDetailView {
  void updateLoading();
  void updateLoadingOrder();
  void removeBox(Box box);
  void changePosition(Box box, int newIdBox, String msg);
  void updateMsg(String msg, bool isError);
  void updateInfoOrder(Map<String, dynamic> info);
  void updateGridView(List<Box> listBox);
  void onClickBox(int index, int orderId);
  void onClickMoveBox();
  void onClickRemoveBox();
}
