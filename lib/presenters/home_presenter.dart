import '/api/api_services.dart';
import '/models/entity/storage.dart';
import '/models/home_model.dart';
import '/views/home_view.dart';

class HomePresenter {
  HomeModel _model;
  HomeView _view;
  HomePresenter() {
    this._model = HomeModel();
  }

  get model => this._model;

  get view => this._view;

  set view(value) => this._view = value;

  Future<void> loadList(int page, int size, String jwt, String address) async {
    try {
      var response =
          await ApiServices.loadListStorage(page, size, jwt, address);
      List<Storage> newItems = response.data['data']
          .map<Storage>((e) => Storage.fromMap(e))
          .toList();
      final isLastPage = newItems.length < size;
      if (isLastPage) {
        _model.pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = size + newItems.length;
        _model.pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (e) {
      _model.pagingController.error = e;
    } finally {
      _view.updateSearch();
    }
  }

  void onClickSearch(String search) {
    _model.searchAddress = search;
    view.updateSearch();
  }

  Future<bool> deleteStorage(String jwt, int idStorage) async {
    try {
      var response = await ApiServices.deleteStorage(idStorage, jwt);
      if (response.data == 'Deleted') {
        return true;
      }

      return false;
    } catch (e) {
      return null;
    }
  }
}
