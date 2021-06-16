import 'package:app_warehouse/models/entity/storage.dart';

class HomeModel {
  List<Storage> _listStorage;
  String _searchAddress;
  bool _isLoading;

  HomeModel() {
    _isLoading = false;
    _searchAddress = '';
  }

  get listStorage => this._listStorage;

  set listStorage(value) => this._listStorage = value;

  get searchAddress => this._searchAddress;

  set searchAddress(value) => this._searchAddress = value;

  get isLoading => this._isLoading;

  set isLoading(value) => this._isLoading = value;
}
