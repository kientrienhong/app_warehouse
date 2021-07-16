import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '/models/entity/storage.dart';

class HomeModel {
  String _searchAddress;
  bool _isLoadingRefresh;
  String typeOfSort;
  bool _isPrice;
  bool _isRating;
  get isPrice => this._isPrice;

  set isPrice(value) => this._isPrice = value;

  get isRating => this._isRating;

  set isRating(value) => this._isRating = value;

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
    _isPrice = null;
    _isRating = null;
    pagingController = PagingController(firstPageKey: 0);
    typeOfSort = 'Sort';
  }

  get searchAddress => this._searchAddress;

  set searchAddress(value) => this._searchAddress = value;
}
