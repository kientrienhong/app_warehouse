import '/common/custom_color.dart';
import '/common/custom_text.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> listAction;

  CustomDialog(
      {@required this.title,
      @required this.content,
      @required this.listAction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: CustomText(
        text: title,
        color: Colors.black,
        textAlign: TextAlign.center,
        context: context,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      content: CustomText(
          text: content,
          textAlign: TextAlign.center,
          color: CustomColor.black[3],
          context: context,
          fontSize: 24),
      actions: listAction,
    );
  }
}
