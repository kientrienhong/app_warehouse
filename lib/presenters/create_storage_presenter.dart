import 'dart:io';

import '/api/api_services.dart';
import '/api/firebase_services.dart';
import '/helpers/firebase_storage_helper.dart';
import '/helpers/validator.dart';
import '/models/create_storage_model.dart';
import '/models/entity/user.dart';
import '/views/create_storage_view.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreateStoragePresenter {
  CreateStorageView _view;
  CreateStorageModel _model;
  get view => this._view;

  set view(value) => this._view = value;

  get model => this._model;

  CreateStoragePresenter() {
    _model = CreateStorageModel();
  }

  void onHandleAddImage(String typeList, File image) {
    List<dynamic> listImage = [...model.allImage[typeList]];
    listImage.add({'file': image, 'id': null});
    view.updateGridView(typeList, listImage);
  }

  void onHandleEditImage(String typeList, File image, int index) {
    List<dynamic> listImage = [...model.allImage[typeList]];
    listImage[index] = {'file': image, 'id': listImage[index]['id']};
    view.updateGridView(typeList, listImage);
  }

  void onHanldeDeleteImage(String typeList, int index) {
    List<dynamic> listImage = [...model.allImage[typeList]];
    listImage.removeAt(index);
    view.updateGridView(typeList, listImage);
  }

  String validate(String name, String address, String description,
      String amountShelves, String priceSmallBox, String priceBigBox) {
    String result = '';
    List<String> invalidMsg = [];
    if (name.isEmpty) {
      invalidMsg.add('Name');
    }

    if (address.isEmpty) {
      invalidMsg.add('Address');
    }

    if (description.isEmpty) {
      invalidMsg.add('Description');
    }

    if (name.isEmpty) {
      invalidMsg.add('Name');
    }

    if (amountShelves != null) if (amountShelves.isEmpty) {
      invalidMsg.add('Amount Shelves');
    }

    if (priceSmallBox.isEmpty) {
      invalidMsg.add('Price small box');
    }

    if (priceBigBox.isEmpty) {
      invalidMsg.add('Price big box');
    }

    if (invalidMsg.length > 0) {
      result = invalidMsg.join(', ');
      result += ' must be filled\n';
    }
    if (amountShelves != null) if (amountShelves.isNotEmpty) {
      if (Validator.isNumeric(amountShelves) == false) {
        result += 'Please enter valid amount shelves\n';
      }
    }
    if (priceSmallBox.isNotEmpty) {
      if (Validator.isNumeric(priceSmallBox) == false) {
        result += 'Please enter valid price small box\n';
      }
    }

    if (priceBigBox.isNotEmpty) {
      if (Validator.isNumeric(priceBigBox) == false) {
        result += 'Please enter valid price big box\n';
      }
    }

    if (_model.allImage['imageStorage'].length == 0) {
      result += 'Please add gallery storage\n';
    }

    if (_model.allImage['paperStorage'].length == 0) {
      result += 'Please add paperwork storage\n';
    }

    return result;
  }

  Future<List<Map>> uploadImage(
      String type, List<dynamic> image, String email, int idStorage) async {
    UploadTask task;
    return FirebaseStorageHelper.uploadImage(
        type, image, task, email, idStorage);
  }

  void updateExistData(List<dynamic> listImage) {
    listImage.forEach((element) {
      if (element['type'] == 0) {
        _model.allImage['imageStorage'].add(element);
      } else {
        _model.allImage['paperStorage'].add(element);
      }
    });
  }

  Future<List<Map<String, dynamic>>> formatDataCreate(
      String email, int storageId, List<dynamic> reponseImages) async {
    List<Map> listImageStorage = await uploadImage('imageStorage',
        _model.allImage['imageStorage'].toList(), email, storageId);
    List<Map> listPaperStorage = await uploadImage('paperworker',
        _model.allImage['paperStorage'].toList(), email, storageId);
    List<Map<String, dynamic>> listResult = [];
    int index = 0;
    int indexResponseImages = 0;
    _model.allImage['imageStorage'].forEach((e) {
      if (e['imageUrl'] == null && listImageStorage.length > 0) {
        Map image = listImageStorage[index];

        listResult.add({
          "imageUrl": image['imageUrl'],
          'type': 0,
          'id': reponseImages[indexResponseImages++]['id'],
          'storageId': storageId,
          'location': image['location']
        });
        if (listResult.last['id'] == null) listResult.last.remove('id');
        if (listResult.last['storageId'] == null)
          listResult.last.remove('storageId');
        index++;
      } else {
        listResult.add(e);
      }
    });
    index = 0;
    _model.allImage['paperStorage'].forEach((e) {
      if (e['imageUrl'] == null && listPaperStorage.length > 0) {
        Map image = listPaperStorage[index];

        listResult.add({
          "imageUrl": image['imageUrl'],
          'type': 1,
          'id': reponseImages[indexResponseImages++]['id'],
          'storageId': storageId,
          'location': image['location']
        });
        if (listResult.last['id'] == null) listResult.last.remove('id');
        if (listResult.last['storageId'] == null)
          listResult.last.remove('storageId');
        index++;
      } else {
        listResult.add(e);
      }
    });
    return listResult;
  }

  Future<List<Map<String, dynamic>>> formatData(
      String email, int storageId) async {
    List<Map> listImageStorage = await uploadImage(
        'imageStorage', _model.allImage['imageStorage'], email, storageId);
    List<Map> listPaperStorage = await uploadImage(
        'paperworker', _model.allImage['paperStorage'], email, storageId);

    List<Map<String, dynamic>> listResult = [];
    listImageStorage.forEach((element) {
      if (element['id'] == null) element.remove('id');
      listResult.add(element);
    });
    listPaperStorage.forEach((element) {
      if (element['id'] == null) element.remove('id');
      listResult.add(element);
    });
    return listResult;
  }

  Future<bool> onHandleEditStorage(
      int storageId,
      int id,
      String name,
      String address,
      String description,
      User user,
      String priceSmallBox,
      String priceBigBox) async {
    _view.updateLoading();
    try {
      String validateMsg = validate(
          name, address, description, null, priceSmallBox, priceBigBox);
      if (validateMsg != '') {
        _view.updateMsg(validateMsg, true);
        return false;
      }

      List<Map<String, dynamic>> responseUploadImage =
          await formatData(user.email, storageId);

      var response = await ApiServices.updateStorage(
          id,
          name,
          address,
          description,
          double.parse(priceSmallBox),
          double.parse(priceBigBox),
          responseUploadImage,
          user.jwtToken);
      if (response.data == 'Update success') {
        _view.updateMsg(response.data, false);
        return true;
      } else {
        _view.updateMsg(response.data['error']['message'], true);
        return false;
      }
    } catch (e) {
      _view.updateMsg('Upload failed', true);
      throw Exception(e);
    } finally {
      _view.updateLoading();
    }
  }

  Future<bool> onHandleAddStorage(
      String name,
      String address,
      String description,
      String amountShelves,
      User user,
      String priceSmallBox,
      String priceBigBox) async {
    _view.updateLoading();
    try {
      String validateMsg = validate(name, address, description, amountShelves,
          priceSmallBox, priceBigBox);
      if (validateMsg != '') {
        _view.updateMsg(validateMsg, true);
        return false;
      }

      List<Map<String, dynamic>> tempListImage = [];
      int index = 0;
      _model.allImage['imageStorage'].forEach((element) {
        tempListImage.add(
            {'imageUrl': null, 'type': 0, 'location': (index++).toString()});
      });
      index = 0;
      _model.allImage['paperStorage'].forEach((element) {
        tempListImage.add(
            {'imageUrl': null, 'type': 1, 'location': (index++).toString()});
      });

      var responseCreate = await ApiServices.addStorage(
          name,
          address,
          description,
          int.parse(amountShelves),
          int.parse(priceSmallBox),
          int.parse(priceBigBox),
          tempListImage,
          user.jwtToken);

      if (responseCreate.data['error'] == null) {
        int storageId = responseCreate.data['id'];
        List<Map<String, dynamic>> responseUploadImage = await formatDataCreate(
            user.email, storageId, responseCreate.data['images']);
        var reponseUpdate = await ApiServices.updateStorage(
            storageId,
            name,
            address,
            description,
            double.parse(priceSmallBox),
            double.parse(priceBigBox),
            responseUploadImage,
            user.jwtToken);
        if (reponseUpdate.data == 'Update success') {
          _view.updateMsg('Create sucessfully', false);
          return true;
        } else {
          _view.updateMsg(reponseUpdate.data['error']['message'], true);
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      _view.updateMsg('Upload failed', true);
      throw Exception(e);
    } finally {
      _view.updateLoading();
    }
  }
}
