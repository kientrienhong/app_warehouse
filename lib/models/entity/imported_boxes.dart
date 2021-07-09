import 'package:appwarehouse/models/entity/box.dart';
import 'package:flutter/cupertino.dart';

class ImportedBoxes with ChangeNotifier {
  Map<int, dynamic> importedShelves;
  List<Map<String, dynamic>> listResult;
  Map<int, int> boxInDifferentStorage;
  ImportedBoxes() {
    importedShelves = {};
    listResult = [];
    boxInDifferentStorage = {};
  }

  setImportedBoxes(ImportedBoxes importedBoxes) {
    importedShelves = importedBoxes.importedShelves;
    listResult = importedBoxes.listResult;
    notifyListeners();
  }

  void undoBox(Box box, int indexOfListResult, int idShelf) {
    try {
      if (boxInDifferentStorage[box.id] != null) {
        if (boxInDifferentStorage.keys.length == 1) {
          boxInDifferentStorage.clear();
        } else
          boxInDifferentStorage.remove(box.id);
      }

      int index = importedShelves[idShelf].indexWhere((e) => e.id == box.id);
      importedShelves[idShelf][index] = Box(
          id: box.id,
          boxCode: null,
          price: null,
          size: null,
          orderId: null,
          position: box.position,
          status: 1,
          type: null);

      if (box.type == 2) {
        String row = box.position[0];
        int nextPosition = int.parse(box.position[1]) + 1;
        importedShelves[idShelf].insert(
            index,
            Box(
                id: box.id + 1,
                boxCode: null,
                price: null,
                size: null,
                orderId: null,
                position: '$row$nextPosition',
                status: 1,
                type: null));
      }
      listResult.removeAt(indexOfListResult);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  void addShelf(int idShelf, List<Box> listBox) {
    if (importedShelves.containsKey(idShelf)) {
      importedShelves.remove(idShelf);
    }
    importedShelves.putIfAbsent(idShelf, () => listBox);
    notifyListeners();
  }

  void addBox(Map<String, dynamic> result, bool isSameStorage) {
    print(result);
    if (isSameStorage == false) {
      boxInDifferentStorage.putIfAbsent(result['boxId'], () => result['boxId']);
    }
    listResult.add(result);
    notifyListeners();
  }
}
