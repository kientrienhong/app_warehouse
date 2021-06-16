import 'package:app_warehouse/common/custom_text.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends TextButton {
  final String text;
  final Color textColor;
  final BuildContext context;
  final int fontSize;
  final Function onPressFunction;
  final isLoading;
  CustomTextButton(
      {@required this.text,
      @required this.isLoading,
      @required this.textColor,
      @required this.context,
      @required this.onPressFunction,
      @required this.fontSize})
      : super(
            child: isLoading == true
                ? SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : CustomText(
                    text: text,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    context: context,
                    fontSize: fontSize),
            onPressed: onPressFunction);
}
