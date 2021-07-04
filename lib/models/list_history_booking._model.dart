import '/models/entity/order.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ListHistoryBookingModel {
  PagingController<int, dynamic> _pagingController;

  get pagingController => this._pagingController;

  set pagingController(value) => this._pagingController = value;
  bool _isLoading;

  get isLoading => this._isLoading;

  set isLoading(value) => this._isLoading = value;

  ListHistoryBookingModel() {
    _isLoading = false;
    pagingController = PagingController(firstPageKey: 0);
  }
}
