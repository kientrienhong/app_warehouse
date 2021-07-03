import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '/models/entity/storage.dart';

class HomeModel {
  String _searchAddress;
  bool _isLoading;
  PagingController<int, Storage> pagingController;

  HomeModel() {
    _isLoading = false;
    _searchAddress = '';
    pagingController = PagingController(firstPageKey: 0);
  }

  get searchAddress => this._searchAddress;

  set searchAddress(value) => this._searchAddress = value;

  get isLoading => this._isLoading;

  set isLoading(value) => this._isLoading = value;
}
