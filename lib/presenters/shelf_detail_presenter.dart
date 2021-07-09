import 'package:appwarehouse/api/api_services.dart';
import 'package:appwarehouse/models/entity/box.dart';
import 'package:appwarehouse/models/shelf_detail_model.dart';
import 'package:appwarehouse/views/shelf_detail_view.dart';

class ShelfDetailPresenter {
  ShelfDetailModel _model;
  ShelfDetailView _view;
  get model => this._model;

  set model(value) => this._model = value;

  get view => this._view;

  set view(value) => this._view = value;

  ShelfDetailPresenter() {
    _model = ShelfDetailModel();
  }

  void fetchListBox(String jwt, int shelfId) async {
    try {
      _view.updateLoading();
      var response = await ApiServices.loadDeatailShelf(jwt, shelfId);
      print(response.data['boxes']);
      List<Box> listBox =
          response.data['boxes'].map<Box>((e) => Box.fromMap(e)).toList();
      _model.listBox = listBox;
      _view.updateGridView(listBox);
    } catch (e) {
      print(e.toString());
    } finally {
      _view.updateLoading();
    }
  }
}
