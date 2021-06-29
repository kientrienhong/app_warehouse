import '/api/api_services.dart';
import '/models/change_password_model.dart';
import '/views/change_password_view.dart';

class ChangePasswordPresenter {
  ChangePasswordView _view;
  ChangePasswordModel _model;
  get view => this._view;

  set view(value) => this._view = value;

  get model => this._model;

  ChangePasswordPresenter() {
    _model = ChangePasswordModel();
  }

  String validate(
      String newPassword, String oldPassword, String confirmPassword) {
    String result = '';
    List<String> invalidMsg = [];
    if (oldPassword.isEmpty) {
      invalidMsg.add('Current Password');
    }

    if (newPassword.isEmpty) {
      invalidMsg.add('New password');
    }

    if (confirmPassword.isEmpty) {
      invalidMsg.add('Confirm password');
    }

    if (invalidMsg.length > 0) {
      result = invalidMsg.join(', ');
      result += ' must be filled\n';
    }
    if (confirmPassword.isNotEmpty && newPassword.isNotEmpty) {
      if (confirmPassword != newPassword) {
        result += 'New passowrd must be match with confirm password';
      }
    }
    return result;
  }

  Future<void> onHandleChangePassword(String newPassword, String oldPassword,
      String confirmPassword, String jwt) async {
    try {
      _view.updateLoading();
      String validateMsg = validate(newPassword, oldPassword, confirmPassword);
      if (validateMsg != '') {
        _view.updateMsg(validateMsg, true);
        return;
      }

      await ApiServices.changePassword(
          newPassword, oldPassword, confirmPassword, jwt);
      _view.updateMsg('Change sucessfull', false);
    } catch (e) {
      _view.updateMsg('Wrong password', true);
      throw Exception('Not found');
    } finally {
      _view.updateLoading();
    }
  }
}
