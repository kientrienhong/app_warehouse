import 'package:appwarehouse/api/api_services.dart';
import 'package:appwarehouse/models/bill_model.dart';
import 'package:appwarehouse/models/entity/order.dart';
import 'package:appwarehouse/models/entity/order_customer.dart';
import 'package:appwarehouse/views/bill_view.dart';

class BillPresenter {
  BillView _view;
  BillModel _model;
  get view => this._view;

  set view(value) => this._view = value;

  get model => this._model;
  BillPresenter() {
    _model = BillModel();
  }

  void fetchPage(int pageKey, String jwt, int size) async {
    try {
      var response = await ApiServices.loadListOrder(pageKey, size, jwt);
      List<OrderCustomer> newItems = response.data['data']
          .map<OrderCustomer>((e) => OrderCustomer.fromMap(e))
          .toList();

      final isLastPage = newItems.length < size;
      if (isLastPage) {
        _model.pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = size + newItems.length;
        _model.pagingController.appendPage(newItems, nextPageKey);
      }
      _view.updateView();
    } catch (e) {
      print(e.toString());
      _model.pagingController.error = e;
    }
  }
}
