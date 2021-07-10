import 'package:appwarehouse/models/entity/order_customer.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BillModel {
  PagingController _pagingController;
  PagingController get pagingController => this._pagingController;
  bool _isSearch;
  bool _isLoading;
  OrderCustomer _order;

  get order => this._order;

  set order(value) => this._order = value;
  get isSearch => this._isSearch;

  set isSearch(value) => this._isSearch = value;

  get isLoading => this._isLoading;

  set isLoading(value) => this._isLoading = value;
  set pagingController(PagingController value) =>
      this._pagingController = value;

  BillModel() {
    _pagingController = PagingController<int, OrderCustomer>(firstPageKey: 0);
    _isSearch = false;
    _isLoading = false;
    _order = null;
  }
}
