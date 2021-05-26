import 'package:app_warehouse/common/custom_app_bar.dart';
import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:app_warehouse/common/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BillProtectingService extends StatelessWidget {
  final Map<String, dynamic> data;

  BillProtectingService({this.data});

  Widget _buildOptionBox(
      {@required BuildContext context,
      @required Size deviceSize,
      @required String price,
      @required String imagePath,
      @required String size}) {
    return Row(
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
                  text: '1',
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

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        isHome: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: deviceSize.width,
          height: deviceSize.height * 1.3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                CustomSizedBox(
                  context: context,
                  height: 8,
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
                      text: data['name'],
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
                        text: data['address'],
                        color: CustomColor.black,
                        context: context,
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
                      text: '1',
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
                      text: '1.000.000đ',
                      color: CustomColor.purple,
                      context: context,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                CustomSizedBox(
                  context: context,
                  height: 40,
                ),
                _buildOptionBox(
                    context: context,
                    deviceSize: deviceSize,
                    price: '400.000đ',
                    imagePath: 'assets/images/smallBox.png',
                    size: '0.5m x 1m x 2m'),
                CustomSizedBox(
                  context: context,
                  height: 32,
                ),
                _buildOptionBox(
                    context: context,
                    deviceSize: deviceSize,
                    price: '750.000đ',
                    imagePath: 'assets/images/largeBox.png',
                    size: '1m x 1m x 2m'),
                CustomSizedBox(
                  context: context,
                  height: 32,
                ),
                QrImage(
                  data: 'test',
                  size: 200.0,
                  version: 2,
                ),
                CustomSizedBox(
                  context: context,
                  height: 24,
                ),
                CustomText(
                  text: 'Expired date: 07/07/7777',
                  color: CustomColor.black[1],
                  context: context,
                  fontSize: 16,
                ),
                CustomSizedBox(
                  context: context,
                  height: 24,
                ),
                Container(
                  height: 38,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: CustomColor.lightBlue),
                  child: CustomTextButton(
                      text: 'Done',
                      textColor: CustomColor.green,
                      context: context,
                      onPressFunction: () {},
                      fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
