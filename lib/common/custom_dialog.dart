import 'package:appwarehouse/common/custom_sizebox.dart';

import '/common/custom_color.dart';
import '/common/custom_text.dart';
import 'package:flutter/material.dart';

class CustomDeleteDialog extends StatefulWidget {
  final String title;
  final String content;
  final bool isLoading;
  final Function deleteFunction;
  final bool isError;
  final String errorMsg;
  CustomDeleteDialog({
    this.isError: false,
    this.errorMsg,
    @required this.title,
    @required this.deleteFunction,
    @required this.isLoading,
    @required this.content,
  });

  @override
  State<CustomDeleteDialog> createState() => _CustomDeleteDialogState();
}

class _CustomDeleteDialogState extends State<CustomDeleteDialog> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: CustomText(
        text: widget.title,
        color: Colors.black,
        textAlign: TextAlign.center,
        context: context,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      content: Container(
        height: deviceSize.height / 6,
        child: Column(children: [
          CustomText(
              text: widget.content,
              textAlign: TextAlign.center,
              color: CustomColor.black[3],
              context: context,
              fontSize: 24),
          if (widget.isError == true)
            CustomSizedBox(
              context: context,
              height: 8,
            ),
          if (widget.isError == true)
            CustomText(
              text: widget.errorMsg,
              color: CustomColor.red,
              context: context,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          CustomSizedBox(
            context: context,
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.isLoading == false
                  ? TextButton(
                      onPressed: widget.deleteFunction,
                      child: CustomText(
                        text: 'Delete',
                        color: Colors.red,
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ))
                  : SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: CustomText(
                    text: 'Cancel',
                    color: CustomColor.black,
                    context: context,
                    fontSize: 16,
                  ))
            ],
          )
        ]),
      ),
    );
  }
}
