import '/common/custom_app_bar.dart';
import '/common/custom_button.dart';
import '/common/custom_color.dart';
import '/common/custom_input.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import '/models/entity/user.dart';
import '/presenters/change_password_presenter.dart';
import '/views/change_password_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAppBar(
                isHome: false,
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              CustomText(
                text: 'Change password',
                color: CustomColor.black,
                context: context,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              CustomSizedBox(
                context: context,
                height: 48,
              ),
              ChangePasswordForm()
            ],
          ),
        ),
      ),
    );
  }
}

class ChangePasswordForm extends StatefulWidget {
  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm>
    implements ChangePasswordView {
  TextEditingController _currentPasswordController;
  TextEditingController _newPasswordController;
  TextEditingController _confirmNewPasswordController;

  FocusNode _currentPasswordFocusNode;
  FocusNode _newPasswordFocusNode;
  FocusNode _confirmNewPasswordFocusNode;
  ChangePasswordPresenter presenter;
  @override
  void initState() {
    super.initState();
    presenter = ChangePasswordPresenter();
    presenter.view = this;
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();

    _currentPasswordFocusNode = FocusNode();
    _newPasswordFocusNode = FocusNode();
    _confirmNewPasswordFocusNode = FocusNode();
  }

  @override
  updateMsg(String msg, bool isError) {
    setState(() {
      presenter.model.msg = msg;
      presenter.model.isError = isError;
    });
  }

  @override
  updateLoading() {
    setState(() {
      presenter.model.isLoading = !presenter.model.isLoading;
    });
  }

  @override
  onHandleChangePasword(String password, String oldPassword, String confirm) {
    User user = Provider.of<User>(context, listen: false);
    presenter.onHandleChangePassword(
        password, oldPassword, confirm, user.jwtToken, user.idTokenFirebase);
  }

  Widget _buildMsg({BuildContext context}) {
    if (presenter.model.isError) {
      if (presenter.model.msg.length > 0) {
        return CustomText(
            text: presenter.model.msg,
            color: CustomColor.red,
            textAlign: TextAlign.center,
            maxLines: 2,
            context: context,
            fontSize: 16);
      }
    } else {
      return CustomText(
          text: presenter.model.msg,
          color: CustomColor.green,
          maxLines: 2,
          context: context,
          fontSize: 16);
    }

    return Container();
  }

  @override
  void dispose() {
    super.dispose();
    presenter = ChangePasswordPresenter();
    presenter.view = this;
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();

    _currentPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmNewPasswordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Column(children: [
          CustomOutLineInput(
            isDisable: false,
            deviceSize: deviceSize,
            labelText: 'Current Password',
            controller: _currentPasswordController,
            focusNode: _currentPasswordFocusNode,
            nextNode: _newPasswordFocusNode,
            isSecure: true,
          ),
          CustomOutLineInput(
            isDisable: false,
            deviceSize: deviceSize,
            labelText: 'New password',
            controller: _newPasswordController,
            focusNode: _newPasswordFocusNode,
            nextNode: _confirmNewPasswordFocusNode,
            isSecure: true,
          ),
          CustomOutLineInput(
            isDisable: false,
            deviceSize: deviceSize,
            labelText: 'Confirm new password',
            controller: _confirmNewPasswordController,
            focusNode: _confirmNewPasswordFocusNode,
            isSecure: true,
          ),
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          _buildMsg(context: context),
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          CustomButton(
              isLoading: presenter.model.isLoading,
              height: 32,
              text: 'Done',
              width: double.infinity,
              textColor: CustomColor.green,
              onPressFunction: () => onHandleChangePasword(
                  _newPasswordController.text,
                  _currentPasswordController.text,
                  _confirmNewPasswordController.text),
              buttonColor: CustomColor.lightBlue,
              borderRadius: 8)
        ]),
      ],
    );
  }
}
