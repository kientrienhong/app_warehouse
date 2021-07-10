import 'package:appwarehouse/api/api_services.dart';
import 'package:appwarehouse/models/detail_bill_screen_model.dart';
import 'package:appwarehouse/views/detail_bill_view.dart';

class DetailBillScreenPresenter {
  DetailBillView _view;
  DetailBillScreenModel _model;
  get view => this._view;

  set view(value) => this._view = value;

  get model => this._model;

  set model(value) => this._model = value;

  DetailBillScreenPresenter() {
    _model = DetailBillScreenModel();
  }

  void formatData(List<dynamic> boxUsed) {
    print(boxUsed);
    boxUsed.forEach((e) {
      if (e['boxType'] == 2) {
        if (_model.positionLargeBox.containsKey("Shelf - ${e['shelfId']}")) {
          _model.positionLargeBox["Shelf - ${e['shelfId']}"] +=
              ', ' + e['boxPosition'];
          return;
        }
        _model.positionLargeBox
            .putIfAbsent("Shelf - ${e['shelfId']}", () => e['boxPosition']);
      } else {
        if (_model.positionSmallBox.containsKey("Shelf - ${e['shelfId']}")) {
          _model.positionSmallBox["Shelf - ${e['shelfId']}"] +=
              ', ' + e['boxPosition'];
          return;
        }
        _model.positionSmallBox
            .putIfAbsent("Shelf - ${e['shelfId']}", () => e['boxPosition']);
      }
    });
  }

  void handleOnClick(String jwt, int idOrder, String msg) async {
    try {
      _view.updateLoading();
      var response = await ApiServices.deleteBoxes(jwt, idOrder, msg);
      if (response.data is String) {
        _view.updateMsg('Check out sucesfull', false);
        _model.isAlreadyCheckOut = true;
      } else {
        _view.updateMsg('Check out failed', true);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      _view.updateLoading();
    }
  }
}
