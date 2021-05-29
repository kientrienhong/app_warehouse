import 'package:app_warehouse/common/bill_info_widget.dart';
import 'package:app_warehouse/common/box_info_bill_widget.dart';
import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BillWidget extends StatelessWidget {
  final Map<String, dynamic> data;

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
            price: '400.000đ',
            imagePath: 'assets/images/smallBox.png',
            size: '0.5m x 1m x 2m'),
        CustomSizedBox(
          context: context,
          height: 32,
        ),
        BoxInfoBillWidget(
            deviceSize: deviceSize,
            price: '750.000đ',
            imagePath: 'assets/images/largeBox.png',
            size: '1m x 1m x 2m'),
        CustomSizedBox(
          context: context,
          height: 24,
        ),
        QrImage(
          data: 'test',
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
