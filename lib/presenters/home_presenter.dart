import 'package:app_warehouse/api/api_services.dart';
import 'package:app_warehouse/models/entity/storage.dart';
import 'package:app_warehouse/models/home_model.dart';
import 'package:app_warehouse/views/home_view.dart';

class HomePresenter {
  HomeModel _model;
  HomeView _view;
  HomePresenter() {
    this._model = HomeModel();
  }

  get model => this._model;

  get view => this._view;

  set view(value) => this._view = value;

  Future<List<Storage>> loadList(int page, int size, String jwt) async {
    try {
      var response = await ApiServices.loadListStorage(page, size, jwt);
      List<dynamic> result = response.data['data'];
      List<Storage> listStorage =
          result.map<Storage>((e) => Storage.fromMap(e)).toList();
      print(listStorage);
      return listStorage;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
