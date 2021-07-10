import 'package:appwarehouse/models/entity/box.dart';
import 'package:flutter/cupertino.dart';

class MovedBoxes with ChangeNotifier {
  Box movedBox;

  bool isMoveSamePlace;

  MovedBoxes({this.movedBox, this.isMoveSamePlace});

  MovedBoxes.empty() {
    isMoveSamePlace = false;
    movedBox = null;
  }

  setMovedBoxes(MovedBoxes movedBoxes) {
    movedBox = movedBoxes.movedBox;
    isMoveSamePlace = movedBoxes.isMoveSamePlace;
  }

  MovedBoxes copyWith({Box movedBox, bool isMoveSamePlace}) {
    return MovedBoxes(
        movedBox: movedBox ?? this.movedBox,
        isMoveSamePlace: isMoveSamePlace ?? this.isMoveSamePlace);
  }
}
