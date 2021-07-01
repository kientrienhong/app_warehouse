import 'package:appwarehouse/models/entity/shelf.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class OwnerDetailStorageModel {
  PagingController<int, dynamic> _pagingController;

  get pagingController => this._pagingController;

  set pagingController(value) => this._pagingController = value;
  bool _isLoading;

  get isLoading => this._isLoading;

  set isLoading(value) => this._isLoading = value;

  OwnerDetailStorageModel() {
    _isLoading = false;
    pagingController = PagingController(firstPageKey: 0);
  }
}
