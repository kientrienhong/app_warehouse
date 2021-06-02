import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:flutter/material.dart';

class BoxInfoBillWidget extends StatelessWidget {
  final Size deviceSize;
  final String imagePath;
  final String size;
  final String price;
  final int amount;
  BoxInfoBillWidget(
      {this.amount: 1, this.deviceSize, this.imagePath, this.size, this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: deviceSize.width / 3.5,
          height: deviceSize.height / 6,
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
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  color: CustomColor.black,
                  context: context,
                  text: 'Size: ',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  color: CustomColor.black[2],
                  context: context,
                  text: size,
                  fontSize: 16,
                ),
              ],
            ),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText(
                  text: price,
                  color: CustomColor.purple,
                  context: context,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                CustomSizedBox(
                  context: context,
                  width: 4,
                ),
                CustomText(
                  text: '|' + ' ',
                  color: CustomColor.black,
                  context: context,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                CustomSizedBox(
                  context: context,
                  width: 4,
                ),
                CustomText(
                  text: 'month',
                  color: CustomColor.black[1],
                  context: context,
                  fontSize: 12,
                ),
              ],
            ),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                    text: 'Amount: ',
                    color: CustomColor.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                CustomSizedBox(
                  context: context,
                  width: 16,
                ),
                CustomText(
                  text: amount.toString(),
                  color: CustomColor.purple,
                  context: context,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
