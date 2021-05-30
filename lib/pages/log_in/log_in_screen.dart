import 'package:app_warehouse/common/circle_background.dart';
import 'package:app_warehouse/common/custom_button.dart';
import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_input.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:app_warehouse/pages/customer_screens/bottom_navigation/customer_bottom_navigation.dart';
import 'package:app_warehouse/pages/forgot_password/forgot_password.dart';
import 'package:app_warehouse/pages/owner_screens/bottom_navigation/owner_bottom_navigation.dart';
import 'package:app_warehouse/pages/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatelessWidget {
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
                      Expanded(child: FormLogIn(deviceSize))
                    ],
                  ),
                ),
                Positioned(
                    bottom: 24,
                    child: Container(
                      width: deviceSize.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                              text: 'Haven\'s had account yet?',
                              color: CustomColor.black,
                              context: context,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                          CustomSizedBox(
                            context: context,
                            width: 4,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()),
                              );
                            },
                            child: CustomText(
                                text: 'Sign up',
                                color: CustomColor.purple,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}

class FormLogIn extends StatefulWidget {
  final Size deviceSize;

  FormLogIn(this.deviceSize);

  @override
  _FormLogInState createState() => _FormLogInState();
}

class _FormLogInState extends State<FormLogIn> {
  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();

  String get _email => _controllerEmail.text;
  String get _password => _controllerPassword.text;

  @override
  void dispose() {
    super.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
  }

  Widget _buildButton(
      {@required Color color,
      @required String text,
      @required String imageUrl}) {
    return Container(
      height: 32,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(4), color: color),
      child: TextButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageUrl),
            SizedBox(
              width: 8,
            ),
            CustomText(
              text: text,
              context: context,
              color: CustomColor.white,
              textAlign: TextAlign.start,
              fontSize: 16,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomOutLineInput(
            deviceSize: widget.deviceSize,
            labelText: 'Email',
            isDisable: false,
            focusNode: _focusNodeEmail,
            nextNode: _focusNodePassword,
            controller: _controllerEmail,
          ),
          CustomOutLineInput(
            deviceSize: widget.deviceSize,
            labelText: 'Password',
            isDisable: false,
            isSecure: true,
            focusNode: _focusNodePassword,
            controller: _controllerPassword,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen()));
            },
            child: CustomText(
                text: 'Forgot Password? ',
                color: CustomColor.purple,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          CustomSizedBox(
            context: context,
            height: 10,
          ),
          _buildButton(
              color: Color(0xFFE16259),
              text: 'Continue with Google',
              imageUrl: 'assets/images/google.png'),
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          _buildButton(
              color: Color(0xFF1877F2),
              text: 'Continue with Facebook',
              imageUrl: 'assets/images/facebook.png'),
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          CustomButton(
              height: 32,
              text: 'Sign in',
              width: double.infinity,
              textColor: CustomColor.white,
              onPressFunction: () {
                if (_email == 'owner') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OwnerBottomNavigation()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomerBottomNavigation()),
                  );
                }
              },
              buttonColor: CustomColor.purple,
              borderRadius: 4),
        ],
      ),
    );
  }
}
