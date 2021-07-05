import 'package:appwarehouse/models/entity/order_customer.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BillModel {
  PagingController _pagingController;
  PagingController get pagingController => this._pagingController;

  set pagingController(PagingController value) =>
      this._pagingController = value;

  BillModel() {
    _pagingController = PagingController<int, OrderCustomer>(firstPageKey: 0);
  }
}
