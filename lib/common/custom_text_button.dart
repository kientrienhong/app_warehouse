import 'package:app_warehouse/common/custom_text.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends TextButton {
  final String text;
  final Color textColor;
  final BuildContext context;
  final int fontSize;
  final Function onPressFunction;
  CustomTextButton(
      {@required this.text,
      @required this.textColor,
      @required this.context,
      @required this.onPressFunction,
      @required this.fontSize})
      : super(
            child: CustomText(
                text: text,
                fontWeight: FontWeight.bold,
                color: textColor,
                context: context,
                fontSize: fontSize),
            onPressed: onPressFunction);
}
