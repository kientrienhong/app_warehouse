import 'package:appwarehouse/models/entity/shelf.dart';
import 'package:appwarehouse/models/entity/storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ChooseStorageModel {
  PagingController<int, Storage> _pagingStorageController;
  PagingController<int, Shelf> _pagingShelfController;
  int _index;
  Storage _previousStorage;
  int _currentStorageId;

  get currentStorageId => this._currentStorageId;

  set currentStorageId(value) => this._currentStorageId = value;
  get previousStorage => this._previousStorage;

  set previousStorage(value) => this._previousStorage = value;
  get index => this._index;

  set index(value) => this._index = value;
  get pagingStorageController => this._pagingStorageController;

  set pagingStorageController(value) => this._pagingStorageController = value;

  get pagingShelfController => this._pagingShelfController;

  set pagingShelfController(value) => this._pagingShelfController = value;
  ChooseStorageModel() {
    _pagingShelfController = PagingController(firstPageKey: 0);
    _pagingStorageController = PagingController(firstPageKey: 0);
    _index = 0;
    _currentStorageId = _previousStorage.id;
  }
}
