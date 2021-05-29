import 'package:app_warehouse/common/circle_background.dart';
import 'package:app_warehouse/common/custom_app_bar.dart';
import 'package:app_warehouse/common/custom_button.dart';
import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_input.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: CustomColor.white,
        body: SingleChildScrollView(
          child: Container(
            width: deviceSize.width,
            height: deviceSize.height * 1.3,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CircleBackground(
                    positionLeft: -deviceSize.width / 2,
                    positionTop: -deviceSize.height / 4,
                    size: deviceSize.width * 0.9),
                CircleBackground(
                    positionLeft: deviceSize.width / 1.5,
                    positionTop: deviceSize.height / 10,
                    size: deviceSize.width * 0.2),
                CircleBackground(
                    positionLeft: -deviceSize.width / 3,
                    positionTop: deviceSize.height / 1.3,
                    size: deviceSize.width * 0.8),
                CircleBackground(
                    positionLeft: deviceSize.width / 1.17,
                    positionTop: deviceSize.height / 3,
                    size: deviceSize.width * 0.25),
                Positioned(
                    top: deviceSize.height / 20,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: CustomAppBar(
                        isHome: false,
                      ),
                    )),
                Container(
                  width: deviceSize.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomSizedBox(
                        context: context,
                        height: 152,
                      ),
                      Image.asset('assets/images/logo.png'),
                      CustomSizedBox(
                        context: context,
                        height: 56,
                      ),
                      Expanded(child: SignUpForm(deviceSize))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class SignUpForm extends StatefulWidget {
  final Size deviceSize;

  SignUpForm(this.deviceSize);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();
  final _focusName = FocusNode();
  final _focusAddress = FocusNode();
  final _focusConfirmPassword = FocusNode();
  final _focusPhone = FocusNode();
  String _role;
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerAddress = TextEditingController();
  final _controllerConfirmPassword = TextEditingController();
  final _controllerPhone = TextEditingController();

  String get _email => _controllerEmail.text;
  String get _password => _controllerPassword.text;
  String get _name => _controllerName.text;
  String get _address => _controllerAddress.text;
  String get _confirmPassword => _controllerConfirmPassword.text;

  @override
  void dispose() {
    super.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusName.dispose();
    _focusConfirmPassword.dispose();
    _focusAddress.dispose();
    _focusPhone.dispose();

    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerName.dispose();
    _controllerAddress.dispose();
    _controllerConfirmPassword.dispose();
    _controllerPhone.dispose();
    _role = 'Customer';
  }

  void onChangeDropdownCButton(String value) {
    setState(() {
      _role = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomOutLineInput(
            deviceSize: widget.deviceSize,
            labelText: 'Name',
            isDisable: false,
            focusNode: _focusName,
            nextNode: _focusNodeEmail,
            controller: _controllerName,
          ),
          CustomOutLineInput(
            deviceSize: widget.deviceSize,
            labelText: 'Email',
            isDisable: false,
            focusNode: _focusNodeEmail,
            nextNode: _focusName,
            controller: _controllerEmail,
          ),
          CustomOutLineInput(
            deviceSize: widget.deviceSize,
            labelText: 'Address',
            isDisable: false,
            focusNode: _focusAddress,
            controller: _controllerAddress,
            nextNode: _focusPhone,
          ),
          CustomOutLineInput(
            deviceSize: widget.deviceSize,
            labelText: 'Phone',
            isDisable: false,
            focusNode: _focusPhone,
            controller: _controllerPhone,
            textInputType: TextInputType.number,
          ),
          CustomOutLineInput(
            deviceSize: widget.deviceSize,
            labelText: 'Password',
            isDisable: false,
            isSecure: true,
            backgroundColorLabel: CustomColor.lightBlue,
            focusNode: _focusNodePassword,
            controller: _controllerPassword,
            nextNode: _focusConfirmPassword,
          ),
          CustomOutLineInput(
            deviceSize: widget.deviceSize,
            labelText: 'Confirm Password',
            isDisable: false,
            backgroundColorLabel: CustomColor.lightBlue,
            isSecure: true,
            focusNode: _focusConfirmPassword,
            controller: _controllerConfirmPassword,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                border: Border.all(color: CustomColor.black[3], width: 1),
                borderRadius: BorderRadius.circular(8)),
            child: DropdownButton(
                icon: ImageIcon(
                  AssetImage('assets/images/arrowDown.png'),
                ),
                iconSize: 16,
                hint: CustomText(
                    text: 'Role',
                    color: CustomColor.black[2],
                    context: context,
                    fontSize: 16),
                underline: Container(
                  width: 0,
                ),
                value: _role,
                onChanged: onChangeDropdownCButton,
                items: <String>['Customer', 'Ower']
                    .map((e) => DropdownMenuItem<String>(
                        value: e,
                        child: CustomText(
                            text: e,
                            color: CustomColor.black,
                            context: context,
                            fontSize: 16)))
                    .toList()),
          ),
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          CustomButton(
              height: 32,
              text: 'Sign up',
              width: double.infinity,
              textColor: CustomColor.white,
              onPressFunction: () {},
              buttonColor: CustomColor.purple,
              borderRadius: 4),
        ],
      ),
    );
  }
}
