import 'dart:io';

import 'package:app_warehouse/models/create_storage_model.dart';
import 'package:app_warehouse/views/create_storage_view.dart';

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

    view.updateView(typeList, listImage);
  }
}
