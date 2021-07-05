import '/api/api_services.dart';
import '/models/entity/order.dart';
import '/models/list_history_booking._model.dart';
import '/views/list_history_booking_view.dart';

class ListHistoryBookingPresenter {
  ListHistoryBookingModel _model;
  ListHistoryBookingview _view;

  get model => this._model;

  get view => this._view;

  set view(value) => this._view = value;

  ListHistoryBookingPresenter() {
    _model = ListHistoryBookingModel();
  }

  void loadListHistoryBooking(int page, int size, String jwt) async {
    try {
      var response = await ApiServices.loadListOrder(page, size, jwt);
      List<dynamic> newItems =
          response.data['data'].map((e) => Order.fromMap(e)).toList();
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
}
