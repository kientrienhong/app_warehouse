import 'package:appwarehouse/models/entity/box.dart';
import 'package:appwarehouse/models/entity/order.dart';

class ShelfDetailModel {
  bool _isLoading;
  List<Box> _listBox;
  int _currentIndex;

  List<Order> _listOrder;
  bool _isLoadingOrder;
  Map<String, dynamic> _infoOrder;
  bool _isError;

  String _msg;
  get isError => this._isError;

  set isError(value) => this._isError = value;

  get msg => this._msg;

  set msg(value) => this._msg = value;

  get infoOrder => this._infoOrder;

  set infoOrder(value) => this._infoOrder = value;
  get isLoadingOrder => this._isLoadingOrder;

  set isLoadingOrder(value) => this._isLoadingOrder = value;
  get currentIndex => this._currentIndex;

  set currentIndex(value) => this._currentIndex = value;

  get listOrder => this._listOrder;

  set listOrder(value) => this._listOrder = value;

  get isLoading => this._isLoading;

  set isLoading(value) => this._isLoading = value;

  get listBox => this._listBox;

  set listBox(value) => this._listBox = value;

  ShelfDetailModel() {
    _isLoading = false;
    _listBox = [];
    _listOrder = [];
    _currentIndex = -1;
    _isError = false;
    _msg = '';
    _isLoadingOrder = false;
    _infoOrder = {'id': '', 'dateRemain': ''};
  }
}
