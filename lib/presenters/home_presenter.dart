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

  Future<void> loadList(int page, int size, String jwt) async {
    try {
      var response = await ApiServices.loadListStorage(
          page, size, jwt, _model.searchAddress);
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

  void onClickSearch(int page, String search, String jwt, int size) {
    _model.searchAddress = search;
    loadList(
      page,
      size,
      jwt,
    );
  }

  Future<bool> deleteStorage(String jwt, int idStorage) async {
    try {
      _view.updateLoadingDeleteStorage();
      var response = await ApiServices.deleteStorage(idStorage, jwt);
      if (response.data == 'Deleted') {
        return true;
      }

      return false;
    } catch (e) {
      return null;
    } finally {
      _view.updateLoadingDeleteStorage();
    }
  }
}
