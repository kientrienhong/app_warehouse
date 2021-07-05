import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ListHistoryBookingModel {
  PagingController<int, dynamic> _pagingController;

  bool _isLoading;
  get pagingController => this._pagingController;

  set pagingController(value) => this._pagingController = value;

  get isLoading => this._isLoading;

  set isLoading(value) => this._isLoading = value;

  ListHistoryBookingModel() {
    _isLoading = false;
    pagingController = PagingController(firstPageKey: 0);
  }
}
