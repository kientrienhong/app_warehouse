import 'package:app_warehouse/common/custom_app_bar.dart';
import 'package:app_warehouse/common/custom_button.dart';
import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_input.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:flutter/material.dart';

class UpdateInfoScreen extends StatelessWidget {
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
                text: 'Change information',
                color: CustomColor.black,
                context: context,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              CustomSizedBox(
                context: context,
                height: 48,
              ),
              UpdateInfoForm()
            ],
          ),
        ),
      ),
    );
  }
}

class UpdateInfoForm extends StatefulWidget {
  @override
  _UpdateInfoFormState createState() => _UpdateInfoFormState();
}

class _UpdateInfoFormState extends State<UpdateInfoForm> {
  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _addressController;
  TextEditingController _phoneController;

  FocusNode _nameFocusNode;
  FocusNode _emailFocusNode;
  FocusNode _addressFocusNode;
  FocusNode _phoneFocusNode;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
    _phoneController = TextEditingController();

    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _addressFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _addressFocusNode.dispose();
    _phoneFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Column(
          children: [
            CustomOutLineInput(
              isDisable: false,
              deviceSize: deviceSize,
              labelText: 'Name',
              controller: _nameController,
              focusNode: _nameFocusNode,
              nextNode: _emailFocusNode,
            ),
            CustomOutLineInput(
              isDisable: true,
              deviceSize: deviceSize,
              labelText: 'Email',
              statusTypeInput: StatusTypeInput.DISABLE,
              controller: _emailController,
              focusNode: _emailFocusNode,
              nextNode: _addressFocusNode,
            ),
            CustomOutLineInput(
              isDisable: false,
              deviceSize: deviceSize,
              labelText: 'Adress',
              controller: _addressController,
              focusNode: _addressFocusNode,
              nextNode: _phoneFocusNode,
            ),
            CustomOutLineInput(
              isDisable: false,
              deviceSize: deviceSize,
              labelText: 'Phone',
              controller: _phoneController,
              focusNode: _phoneFocusNode,
              textInputType: TextInputType.number,
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
          ],
        ),
      ],
    );
  }
}
