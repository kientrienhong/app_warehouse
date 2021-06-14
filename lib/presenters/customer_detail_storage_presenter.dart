import 'package:app_warehouse/models/customer_detail_storage_model.dart';
import 'package:app_warehouse/views/customer_detail_storage_view.dart';

class CustomerDetailStoragePresenter {
  CustomerDetailStorageModel _model;
  CustomerDetailStorageView _view;

  CustomerDetailStoragePresenter({double priceFrom, double priceTo}) {
    _model = CustomerDetailStorageModel(priceFrom, priceTo);
  }

  get model => this._model;

  get view => this._view;

  set view(value) => this._view = value;

  void onHandleChangeQuantity(String value, bool isIncrease) {
    if (isIncrease == true) {
      _model.quantities[value]++;
    } else {
      if (_model.quantities[value] == 0) {
        return;
      }
      _model.quantities[value]--;
    }
    _model.totalPrice =
        ((_model.priceFrom * _model.quantities['amountSmallBox']) +
                (_model.priceTo * _model.quantities['amountBigBox'])) *
            _model.quantities['months'];
    _view.updateQuantity(_model.quantities, _model.totalPrice);
  }
}
