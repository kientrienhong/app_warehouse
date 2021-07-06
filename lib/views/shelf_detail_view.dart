import 'package:appwarehouse/models/entity/box.dart';

abstract class ShelfDetailView {
  void updateLoading();
  void updateGridView(List<Box> listBox);
  void onClickBox();
  void onClickMoveBox();
  void onClickRemoveBox();
}
