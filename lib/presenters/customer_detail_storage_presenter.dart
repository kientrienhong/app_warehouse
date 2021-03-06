import '/api/api_services.dart';

import '/models/customer_detail_storage_model.dart';
import '/views/customer_detail_storage_view.dart';

class CustomerDetailStoragePresenter {
  CustomerDetailStorageModel _model;
  CustomerDetailStorageView _view;

  CustomerDetailStoragePresenter({double priceFrom, double priceTo}) {
    _model = CustomerDetailStorageModel(priceFrom, priceTo);
  }

  get model => this._model;

  get view => this._view;

  set view(value) => this._view = value;

  void onHandleChangeQuantity(String value, bool isIncrease, int remainingBox) {
    if (isIncrease == true) {
      if (value != 'months') {
        int total = _model.quantities['amountSmallBox'] +
            _model.quantities['amountBigBox'] * 2;
        if (total == remainingBox - 1 && value == 'amountBigBox') {
          _view.updateMsgQuantity(true, 'Not enough space in storage');
        } else if (total >= remainingBox) {
          _view.updateMsgQuantity(true, 'Not enough space in storage');
        } else {
          _model.quantities[value]++;
        }
      } else {
        _model.quantities[value]++;
      }
    } else {
      if (_model.quantities[value] == 0) {
        return;
      }
      _model.quantities[value]--;
      _view.updateMsgQuantity(false, '');
    }
    _model.totalPrice =
        ((_model.priceFrom * _model.quantities['amountSmallBox']) +
                (_model.priceTo * _model.quantities['amountBigBox'])) *
            _model.quantities['months'];
    _view.updateQuantity(_model.quantities, _model.totalPrice);
  }

  Future<Map<String, dynamic>> checkOut(
      int idStorage, String jwt, DateTime datePickUp) async {
    try {
      _view.updateLoading();
      var response = await ApiServices.payment(
          _model.totalPrice,
          _model.quantities['months'],
          _model.quantities['amountSmallBox'],
          _model.quantities['amountBigBox'],
          _model.priceFrom,
          _model.priceTo,
          datePickUp,
          idStorage,
          jwt);
      if (response.data['error'] != null) {
        _view.updateMsg(true, 'Pay failed');
        return null;
      }
      _view.updateMsg(false, 'Pay success');

      return {'id': response.data['id'], 'status': response.data['status']};
    } catch (e) {
      _view.updateMsg(true, 'Pay failed due not enough space');
      print(e.toString());
      return null;
    } finally {
      _view.updateLoading();
    }
  }
}
