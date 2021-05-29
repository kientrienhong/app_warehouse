import 'package:app_warehouse/common/custom_app_bar.dart';
import 'package:app_warehouse/common/custom_button.dart';
import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_input.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:flutter/material.dart';

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

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  TextEditingController _currentPasswordController;
  TextEditingController _newPasswordController;
  TextEditingController _confirmNewPasswordController;

  FocusNode _currentPasswordFocusNode;
  FocusNode _newPasswordFocusNode;
  FocusNode _confirmNewPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();

    _currentPasswordFocusNode = FocusNode();
    _newPasswordFocusNode = FocusNode();
    _confirmNewPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
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
          ),
          CustomOutLineInput(
            isDisable: false,
            deviceSize: deviceSize,
            labelText: 'New password',
            controller: _newPasswordController,
            focusNode: _newPasswordFocusNode,
            nextNode: _confirmNewPasswordFocusNode,
          ),
          CustomOutLineInput(
            isDisable: false,
            deviceSize: deviceSize,
            labelText: 'Confirm new password',
            controller: _confirmNewPasswordController,
            focusNode: _confirmNewPasswordFocusNode,
          ),
          CustomSizedBox(
            context: context,
            height: 32,
          ),
          CustomButton(
              height: 32,
              text: 'Done',
              width: double.infinity,
              textColor: CustomColor.green,
              onPressFunction: () {},
              buttonColor: CustomColor.lightBlue,
              borderRadius: 8)
        ]),
      ],
    );
  }
}
