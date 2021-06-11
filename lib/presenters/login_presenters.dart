import 'package:app_warehouse/models/login_model.dart';
import 'package:app_warehouse/mvp/presenter.dart';

class LoginPresenter extends Presenter {
  LoginModel _model;
  LoginPresenter() {
    _model = LoginModel();
  }
}
