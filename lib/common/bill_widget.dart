import 'package:app_warehouse/common/avatar_widget.dart';
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
            price: '400.000 VND',
            imagePath: 'assets/images/smallBox.png',
            size: '0.5m x 1m x 2m'),
        CustomSizedBox(
          context: context,
          height: 32,
        ),
        BoxInfoBillWidget(
            deviceSize: deviceSize,
            price: '750.000 VND',
            imagePath: 'assets/images/largeBox.png',
            size: '1m x 1m x 2m'),
        CustomSizedBox(
          context: context,
          height: 24,
        ),
        Container(
          height: deviceSize.height / 8,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: CustomColor.purple)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AvatarWidget(
                  deviceSize: deviceSize,
                  isHome: false,
                  name: 'Clarren Jessica',
                  imageUrl: 'assets/images/avatar.png',
                  role: 'Owner'),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: deviceSize.height / 16,
                  width: deviceSize.height / 16,
                  color: CustomColor.green,
                  child: TextButton(
                      onPressed: () {},
                      child: Image.asset('assets/images/call.png')),
                ),
              ),
            ],
          ),
        ),
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
