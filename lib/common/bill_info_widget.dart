import 'package:appwarehouse/models/entity/order.dart';

import '/common/custom_color.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import 'package:flutter/material.dart';

class BillInfoWidget extends StatelessWidget {
  final Order data;

  BillInfoWidget({this.data});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
                text: 'ID: ',
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            CustomText(
              text: '#${data.id}',
              color: CustomColor.black,
              context: context,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        CustomSizedBox(
          context: context,
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
                text: 'Name: ',
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            CustomText(
              text: data.name,
              color: CustomColor.black,
              context: context,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        CustomSizedBox(
          context: context,
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
                text: 'Address: ',
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            Container(
              width: deviceSize.width / 2.2,
              child: CustomText(
                text: data.address,
                color: CustomColor.black,
                context: context,
                textAlign: TextAlign.right,
                maxLines: 2,
                fontSize: 14,
              ),
            ),
          ],
        ),
        CustomSizedBox(
          context: context,
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
                text: 'Months: ',
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            CustomText(
              text: data.month.toString(),
              color: CustomColor.purple,
              context: context,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        CustomSizedBox(
          context: context,
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
                text: 'Price: ',
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            CustomText(
              text: '${data.total} VND',
              color: CustomColor.purple,
              context: context,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ],
    );
  }
}
