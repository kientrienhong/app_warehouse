import '/api/api_services.dart';
import '/models/entity/shelf.dart';
import '/models/owner_detail_storage_model.dart';
import '/views/owner_detail_storage_view.dart';

class OwnerDetailStoragePresenter {
  OwnerDetailStorageModel _model;
  OwnerDetailStorageView _view;
  get view => this._view;

  set view(value) => this._view = value;
  get model => this._model;

  set model(value) => this._model = value;

  OwnerDetailStoragePresenter() {
    _model = OwnerDetailStorageModel();
  }

  void loadListShelves(int page, int size, String jwt, int idStorage) async {
    try {
      var response = await ApiServices.loadShelves(page, size, jwt, idStorage);
      List<dynamic> newItems =
          response.data['data'].map((e) => Shelf.fromMap(e)).toList();
      final isLastPage = newItems.length < size;
      if (isLastPage) {
        _model.pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = size + newItems.length;
        _model.pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (e) {
      print(e.toString());
      _model.pagingController.error = e;
    }
  }

  void loadListFeedBack(int page, int size, String jwt, int idStorage) async {
    try {
      var response =
          await ApiServices.loadListFeedback(page, size, jwt, idStorage);
      List<dynamic> newItems = response.data['data'];
      final isLastPage = newItems.length < size;
      if (isLastPage) {
        _model.pagingFeedbackController.appendLastPage(newItems);
      } else {
        final nextPageKey = size + newItems.length;
        _model.pagingFeedbackController.appendPage(newItems, nextPageKey);
      }
    } catch (e) {
      print(e.toString());
      _model.pagingFeedbackController.error = e;
    }
  }

  Future<bool> addShelf(String jwt, int idStorage) async {
    try {
      _view.updateLoadingAddShelf();
      var response = await ApiServices.addShelf(idStorage, jwt);
      if (response.data['error'] != null) {
        return false;
      }
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      _view.updateLoadingAddShelf();
    }
  }

  Future<bool> deleteShelf(String jwt, int idShelf) async {
    try {
      _view.updateLoadingDeleteShelf();
      var response = await ApiServices.deleteShelf(idShelf, jwt);
      if (response.data == 'Deleted') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      _view.updateLoadingDeleteShelf();
    }
  }
}
