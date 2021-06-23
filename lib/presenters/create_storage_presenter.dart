import 'dart:io';

import 'package:app_warehouse/api/api_services.dart';
import 'package:app_warehouse/helpers/firebase_storage_helper.dart';
import 'package:app_warehouse/helpers/validator.dart';
import 'package:app_warehouse/models/create_storage_model.dart';
import 'package:app_warehouse/models/entity/user.dart';
import 'package:app_warehouse/views/create_storage_view.dart';
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
    List<File> listImage = [...model.allImage[typeList]];
    listImage.add(image);
    view.updateGridView(typeList, listImage);
  }

  void onHandleEditImage(String typeList, File image, int index) {
    List<File> listImage = [...model.allImage[typeList]];
    listImage[index] = image;

    view.updateGridView(typeList, listImage);
  }

  void onHanldeDeleteImage(String typeList, int index) {
    List<File> listImage = [...model.allImage[typeList]];
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

    if (amountShelves.isEmpty) {
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
    if (amountShelves.isNotEmpty) {
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

  Future<List<String>> uploadImage(
      String type, List<File> image, String email) async {
    UploadTask task;
    return FirebaseStorageHelper.uploadImage(type, image, task, email);
  }

  Future<List<Map<String, dynamic>>> formatData(String email) async {
    List<String> listImageStorage =
        await uploadImage('storage', _model.allImage['imageStorage'], email);
    List<String> listPaperStorage = await uploadImage(
        'paperworker', _model.allImage['paperStorage'], email);

    List<Map<String, dynamic>> listResult = [];
    listImageStorage.forEach((element) {
      listResult.add({"imageUrl": element, 'type': 0});
    });
    listPaperStorage.forEach((element) {
      listResult.add({"imageUrl": element, 'type': 1});
    });

    return listResult;
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

      List<Map<String, dynamic>> responseUploadImage =
          await formatData(user.email);
      var response = await ApiServices.addStorage(
          name,
          address,
          description,
          int.parse(amountShelves),
          int.parse(priceSmallBox),
          int.parse(priceBigBox),
          responseUploadImage,
          user.jwtToken);
      if (response.data == 'Create Successful!') {
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
}
