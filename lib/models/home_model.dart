import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '/models/entity/storage.dart';

class HomeModel {
  String _searchAddress;
  bool _isLoadingRefresh;

  get isLoadingRefresh => this._isLoadingRefresh;

  set isLoadingRefresh(value) => this._isLoadingRefresh = value;
  bool _isLoadingDeleteStorage;

  get isLoadingDeleteStorage => this._isLoadingDeleteStorage;

  set isLoadingDeleteStorage(value) => this._isLoadingDeleteStorage = value;
  PagingController<int, Storage> pagingController;

  HomeModel() {
    _isLoadingRefresh = false;
    _isLoadingDeleteStorage = false;
    _searchAddress = '';
    pagingController = PagingController(firstPageKey: 0);
  }

  get searchAddress => this._searchAddress;

  set searchAddress(value) => this._searchAddress = value;
}
