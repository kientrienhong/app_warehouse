import 'package:appwarehouse/api/api_services.dart';
import 'package:appwarehouse/models/choose_storage_screen_model.dart';
import 'package:appwarehouse/models/entity/shelf.dart';
import 'package:appwarehouse/models/entity/storage.dart';
import 'package:appwarehouse/views/choose_storage_view.dart';

class ChooseStoragePresenter {
  ChooseStorageModel _model;
  ChooseStorageView _view;
  get model => this._model;

  set model(value) => this._model = value;

  get view => this._view;

  set view(value) => this._view = value;

  ChooseStoragePresenter(int idPreviousStorage) {
    _model = ChooseStorageModel(idPreviousStorage);
  }

  Future<void> loadListStorage(int page, int size, String jwt, String address,
      int idPreviousStorage) async {
    try {
      var response =
          await ApiServices.loadListStorage(page, size, jwt, address);
      List<Storage> newItems = response.data['data']
          .map<Storage>((e) => Storage.fromMap(e))
          .toList();
      newItems = newItems.where((element) => element.status == 2).toList();
      newItems =
          newItems.where((element) => element.id != idPreviousStorage).toList();

      final isLastPage = newItems.length < size;
      if (isLastPage) {
        _model.pagingStorageController.appendLastPage(newItems);
      } else {
        final nextPageKey = size + newItems.length;
        _model.pagingStorageController.appendPage(newItems, nextPageKey);
      }
    } catch (e) {
      print(e.toString());
      _model.pagingStorageController.error = e;
    }
  }

  Future<void> loadListShelves(int page, int size, String jwt, int idStorage,
      int idPreviousShelf) async {
    try {
      var response = await ApiServices.loadShelves(page, size, jwt, idStorage);
      List<Shelf> newItems =
          response.data['data'].map<Shelf>((e) => Shelf.fromMap(e)).toList();
      newItems =
          newItems.where((element) => element.id != idPreviousShelf).toList();
      final isLastPage = newItems.length < size;
      if (isLastPage) {
        _model.pagingShelfController.appendLastPage(newItems);
      } else {
        final nextPageKey = size + newItems.length;
        _model.pagingShelfController.appendPage(newItems, nextPageKey);
      }
    } catch (e) {
      print(e.toString());
      _model.pagingShelfController.error = e;
    }
  }
}
