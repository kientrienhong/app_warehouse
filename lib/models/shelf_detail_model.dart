import 'package:appwarehouse/models/entity/box.dart';

class ShelfDetailModel {
  bool _isLoading;
  List<Box> _listBox;
  get isLoading => this._isLoading;

  set isLoading(value) => this._isLoading = value;

  get listBox => this._listBox;

  set listBox(value) => this._listBox = value;

  ShelfDetailModel() {
    _isLoading = false;
    _listBox = [];
  }
}
