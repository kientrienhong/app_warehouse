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

  Future<List<Storage>> loadList(
      int page, int size, String jwt, String address) async {
    try {
      var response =
          await ApiServices.loadListStorage(page, size, jwt, address);
      List<dynamic> result = response.data['data'];
      List<Storage> listStorage =
          result.map<Storage>((e) => Storage.fromMap(e)).toList();
      return listStorage;
    } catch (e) {
      return null;
    }
  }

  void onClickSearch(String search) {
    _model.searchAddress = search;
    view.updateSearch();
  }

  void deleteStorage(String jwt, int idStorage) async {}
}
