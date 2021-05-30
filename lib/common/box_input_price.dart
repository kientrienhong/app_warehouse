import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_input.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:flutter/material.dart';

class BoxInputPrice extends StatelessWidget {
  final Size deviceSize;
  final BuildContext context;
  final String imagePath;
  final String size;
  final TextEditingController controller;
  final FocusNode nodeCurrent;
  final FocusNode nextNode;

  BoxInputPrice(
      {@required this.deviceSize,
      @required this.context,
      @required this.imagePath,
      @required this.size,
      @required this.controller,
      @required this.nodeCurrent,
      this.nextNode});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: deviceSize.width / 2.6,
          child: Column(
            children: [
              Container(
                width: deviceSize.width / 3,
                height: deviceSize.height / 5,
                child: Center(child: Image.asset(imagePath)),
                decoration: BoxDecoration(
                    color: CustomColor.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 14,
                          color: Color(0x000000).withOpacity(0.06),
                          offset: Offset(0, 6)),
                    ]),
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              Row(
                children: [
                  CustomText(
                    text: 'Size: ',
                    color: CustomColor.black,
                    context: context,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                      text: size,
                      color: CustomColor.black,
                      context: context,
                      fontSize: 16),
                ],
              )
            ],
          ),
        ),
        CustomSizedBox(
          context: context,
          width: 8,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: deviceSize.width / 3,
                child: CustomOutLineInput(
                    controller: controller,
                    textInputType: TextInputType.number,
                    focusNode: nodeCurrent,
                    nextNode: nextNode,
                    isDisable: false,
                    deviceSize: deviceSize,
                    labelText: 'Price'),
              ),
              CustomSizedBox(
                context: context,
                width: 2,
              ),
              CustomText(
                text: '/ month',
                color: CustomColor.black[2],
                context: context,
                fontSize: 12,
              ),
            ])
      ],
    );
  }
}
