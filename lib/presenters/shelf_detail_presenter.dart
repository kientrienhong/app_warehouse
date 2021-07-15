import 'package:appwarehouse/api/api_services.dart';
import 'package:appwarehouse/models/entity/box.dart';
import 'package:appwarehouse/models/entity/order.dart';
import 'package:appwarehouse/models/shelf_detail_model.dart';
import 'package:appwarehouse/views/shelf_detail_view.dart';
import 'package:intl/intl.dart';

class ShelfDetailPresenter {
  ShelfDetailModel _model;
  ShelfDetailView _view;
  get model => this._model;

  set model(value) => this._model = value;

  get view => this._view;

  set view(value) => this._view = value;

  ShelfDetailPresenter() {
    _model = ShelfDetailModel();
  }

  void fetchListBox(String jwt, int shelfId) async {
    try {
      _view.updateLoading();
      var response = await ApiServices.loadDeatailShelf(jwt, shelfId);
      List<Box> listBox =
          response.data['boxes'].map<Box>((e) => Box.fromMap(e)).toList();
      listBox = listBox.map((e) {
        if (e.status == 2) {
          fetchOrder(jwt, e.orderId, false);
        }

        return e.copyWith(shelfId: shelfId);
      }).toList();
      _model.listBox = listBox;
      _view.updateGridView(listBox);
    } catch (e) {
      print(e.toString());
    } finally {
      _view.updateLoading();
    }
  }

  Map<String, dynamic> formatData(Order order) {
    DateTime expiredDate =
        DateFormat('yyyy-MM-dd').parse(order.expiredDate.split('T')[0]);
    DateTime now = DateTime.now();
    int differenceInDays = expiredDate.difference(now).inDays;
    int years = (differenceInDays / 365).floor();
    differenceInDays -= 365 * years;
    int months = (differenceInDays / 30).floor();
    differenceInDays -= months * 30;
    String dateRemain = '';
    if (years > 0) {
      dateRemain += 'Years: $years ';
    }
    if (months > 0) {
      dateRemain += 'Months: $months ';
    }
    if (differenceInDays > 0) {
      dateRemain += 'Days: $differenceInDays ';
    }
    return {'id': order.id.toString(), 'dateRemain': dateRemain};
  }

  Future<void> fetchOrder(String jwt, int orderId, bool isClick) async {
    try {
      if (isClick == true) _view.updateLoadingOrder();
      Order order;
      try {
        order = _model.listOrder.firstWhere((e) => e.id == orderId);
      } catch (e) {
        var response = await ApiServices.getOrder(jwt, orderId);
        order = Order.fromMap(response.data);
        _model.listOrder.add(order);
      }

      if (isClick == true) _view.updateInfoOrder(formatData(order));
    } catch (e) {
      print(e.toString());
    } finally {
      if (isClick == true) _view.updateLoadingOrder();
    }
  }

  Future<bool> changePosition(
      Box box, int newIdBox, String jwt, String msg) async {
    try {
      List<Map<String, dynamic>> listResult = [
        {
          "boxId": box.id,
          "orderId": box.orderId,
          "type": box.type,
          "boxId2": box.type == 2 ? box.id + 1 : null,
          "boxCode": box.boxCode,
          "status": 1
        },
        {
          "boxId": newIdBox,
          "orderId": box.orderId,
          "type": box.type,
          "boxId2": box.type == 2 ? newIdBox + 1 : null,
          "boxCode": box.boxCode,
          "status": 2
        }
      ];
      var response =
          await ApiServices.updateBoxes(box.orderId, jwt, listResult, msg);
      if (response.data is String) {
        return true;
      }

      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
