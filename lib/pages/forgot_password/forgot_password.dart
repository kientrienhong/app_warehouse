import 'package:app_warehouse/common/circle_background.dart';
import 'package:app_warehouse/common/custom_app_bar.dart';
import 'package:app_warehouse/common/custom_button.dart';
import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_input.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:app_warehouse/pages/log_in/log_in_screen.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: CustomColor.white,
        body: SingleChildScrollView(
          child: Container(
            width: deviceSize.width,
            height: deviceSize.height,
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
                      ForgotPasswordForm(deviceSize)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class ForgotPasswordForm extends StatefulWidget {
  final Size deviceSize;

  ForgotPasswordForm(this.deviceSize);
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _focusNodeEmail = FocusNode();
  final _controllerEmail = TextEditingController();
  String get _email => _controllerEmail.text;

  @override
  void dispose() {
    // TODO: implement dispose
    _focusNodeEmail.dispose();
    _controllerEmail.dispose();

    super.dispose();
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: CustomText(
              text: 'Log out',
              color: Colors.black,
              context: context,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            content: CustomText(
                text:
                    'We already sent new password to your email. Please check your mail!',
                color: CustomColor.black,
                context: context,
                maxLines: 2,
                fontSize: 16),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => (LogInScreen()),
                      ),
                      (route) => false,
                    );
                  },
                  child: CustomText(
                    text: 'OK',
                    color: CustomColor.purple,
                    context: context,
                    fontSize: 24,
                  )),
            ],
          );
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
            labelText: 'Email',
            isDisable: false,
            focusNode: _focusNodeEmail,
            controller: _controllerEmail,
          ),
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          CustomButton(
              height: 32,
              text: 'Change Password',
              width: double.infinity,
              textColor: CustomColor.white,
              onPressFunction: () {
                _showDialog(context);
              },
              buttonColor: CustomColor.purple,
              borderRadius: 4),
        ],
      ),
    );
  }
}
