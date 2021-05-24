import 'package:app_warehouse/common/custom_text_button.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final Color buttonColor;
  final Function onPressFunction;
  final Color textColor;
  final String text;
  CustomButton(
      {@required this.height,
      @required this.text,
      @required this.width,
      @required this.textColor,
      @required this.onPressFunction,
      @required this.buttonColor,
      @required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: buttonColor),
      child: CustomTextButton(
        context: context,
        text: text,
        textColor: textColor,
        fontSize: 16,
        onPressFunction: onPressFunction,
      ),
    );
  }
}
