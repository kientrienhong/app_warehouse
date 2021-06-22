import 'package:app_warehouse/common/circle_background.dart';
import 'package:app_warehouse/common/custom_button.dart';
import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_input.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:app_warehouse/models/entity/user.dart';
import 'package:app_warehouse/models/login_model.dart';
import 'package:app_warehouse/pages/customer_screens/bottom_navigation/customer_bottom_navigation.dart';
import 'package:app_warehouse/pages/forgot_password/forgot_password.dart';
import 'package:app_warehouse/pages/owner_screens/bottom_navigation/owner_bottom_navigation.dart';
import 'package:app_warehouse/pages/sign_up/sign_up_screen.dart';
import 'package:app_warehouse/presenters/login_presenters.dart';
import 'package:app_warehouse/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                      Expanded(child: FormLogIn(deviceSize)),
                      Container(
                        width: deviceSize.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                                text: 'Haven\'t had account yet?',
                                color: CustomColor.black,
                                context: context,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            CustomSizedBox(
                              context: context,
                              width: 8,
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
                      ),
                      CustomSizedBox(
                        context: context,
                        height: 8,
                      ),
                    ],
                  ),
                ),
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

class _FormLogInState extends State<FormLogIn> implements LoginView {
  LoginPresenter loginPresenter;

  LoginModel _model;

  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();

  String get _email => _controllerEmail.text;
  String get _password => _controllerPassword.text;

  @override
  void initState() {
    super.initState();
    loginPresenter = LoginPresenter();
    loginPresenter.setView(this);
    _model = loginPresenter.model;
    _controllerEmail.addListener(onChangeInput);
    _controllerPassword.addListener(onChangeInput);
  }

  @override
  void onChangeInput() {
    loginPresenter.handleOnChangeInput(_email, _password);
  }

  @override
  void onClickSignIn(String email, String password) async {
    try {
      User user = Provider.of<User>(context, listen: false);

      final result = await loginPresenter.handleSignIn(email, password);

      if (result != null) {
        user.setUser(user: result);
        if (_model.user.role == UserRole.customer) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => CustomerBottomNavigation()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => OwnerBottomNavigation()));
        }
      }
    } catch (e) {
      loginPresenter.view.updateViewErrorMsg(e.toString());
    }
  }

  @override
  updateLoading() {
    if (mounted)
      setState(() {
        _model.isLoading = !_model.isLoading;
      });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
  }

  @override
  void updateViewStatusButton(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      setState(() {
        _model.isDisableLogin = false;
      });
    } else {
      setState(() {
        _model.isDisableLogin = true;
      });
    }
  }

  @override
  void updateViewErrorMsg(String error) {
    setState(() {
      _model.errorMsg = error;
    });
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
          if (_model.errorMsg.isNotEmpty)
            Container(
              width: double.infinity,
              child: CustomText(
                text: _model.errorMsg,
                color: CustomColor.red,
                context: context,
                textAlign: TextAlign.center,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          CustomSizedBox(
            context: context,
            height: 16,
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
              isLoading: _model.isLoading,
              text: 'Sign in',
              width: double.infinity,
              textColor: CustomColor.white,
              onPressFunction: _model.isDisableLogin == false
                  ? () => onClickSignIn(_email, _password)
                  : null,
              buttonColor: _model.isDisableLogin == false
                  ? CustomColor.purple
                  : CustomColor.black[3],
              borderRadius: 4),
        ],
      ),
    );
  }
}
