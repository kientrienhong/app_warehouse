import '/models/entity/order.dart';

import '/common/bill_info_widget.dart';
import '/common/box_info_bill_widget.dart';
import '/common/custom_color.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import '/common/info_call.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BillWidget extends StatelessWidget {
  final Order data;

  BillWidget({this.data});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Column(
      children: [
        BillInfoWidget(
          data: data,
        ),
        CustomSizedBox(
          context: context,
          height: 40,
        ),
        BoxInfoBillWidget(
            deviceSize: deviceSize,
            price: '${data.smallBoxPrice} VND',
            imagePath: 'assets/images/smallBox.png',
            amount: data.smallBoxQuantity,
            size: '0.5m x 1m x 2m'),
        CustomSizedBox(
          context: context,
          height: 32,
        ),
        BoxInfoBillWidget(
            deviceSize: deviceSize,
            price: '${data.bigBoxPrice} VND',
            imagePath: 'assets/images/largeBox.png',
            amount: data.bigBoxQuantity,
            size: '1m x 1m x 2m'),
        CustomSizedBox(
          context: context,
          height: 24,
        ),
        InfoCall(
          role: 'Owner',
          avatar: data.ownerAvatar,
          deviceSize: deviceSize,
          name: data.ownerName,
          phone: data.ownerPhone,
        ),
        CustomSizedBox(
          context: context,
          height: 24,
        ),
        QrImage(
          data: data.id.toString(),
          size: 88.0,
          version: 2,
        ),
        CustomSizedBox(
          context: context,
          height: 8,
        ),
        CustomText(
          text: 'Expired date: 07/07/7777',
          color: CustomColor.black[1],
          context: context,
          fontSize: 16,
        ),
      ],
    );
  }
}
