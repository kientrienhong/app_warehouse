import 'package:appwarehouse/models/entity/box.dart';
import 'package:flutter/cupertino.dart';

class ImportedBoxes with ChangeNotifier {
  Map<int, dynamic> importedShelves;
  List<Map<String, dynamic>> listResult;

  ImportedBoxes() {
    importedShelves = {};
    listResult = [];
  }

  setImportedBoxes(ImportedBoxes importedBoxes) {
    importedShelves = importedBoxes.importedShelves;
    listResult = importedBoxes.listResult;
    notifyListeners();
  }

  void addShelf(int idShelf, List<Box> listBox) {
    if (importedShelves.containsKey(idShelf)) {
      importedShelves.remove(idShelf);
    }
    importedShelves.putIfAbsent(idShelf, () => listBox);
    notifyListeners();
  }

  void addBox(Map<String, dynamic> result) {
    listResult.add(result);
    notifyListeners();
  }
}
