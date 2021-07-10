import 'package:appwarehouse/models/entity/order_customer.dart';

import '/common/box_info_bill_widget.dart';
import '/common/custom_app_bar.dart';
import '/common/custom_color.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import '/common/info_call.dart';
import '/pages/owner_screens/bill/bill_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailBillScreen extends StatelessWidget {
  final OrderCustomer data;

  DetailBillScreen({this.data});
  DateFormat dateFormater = DateFormat('yyyy-MM-dd');
  final oCcy = new NumberFormat("#,##0", "en_US");

  final positionSmallBox = {'Shelf - 1': 'A1, B2', 'Shelf - 2': 'A2, C1'};
  final positionLargeBox = {
    'Shelf - 1': 'C1',
  };

  Widget _buildPosition(
      {@required Map<String, String> position,
      @required Size deviceSize,
      @required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      width: deviceSize.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSizedBox(
            context: context,
            width: 40,
          ),
          CustomText(
            text: 'Positions: ',
            color: CustomColor.black,
            context: context,
            fontSize: 16,
            textAlign: TextAlign.end,
            fontWeight: FontWeight.bold,
          ),
          CustomSizedBox(
            context: context,
            width: 8,
          ),
          Expanded(
              child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (_, index) {
              String shelf = positionSmallBox.keys.toList()[index];

              return CustomText(
                  text: '$shelf - ${positionSmallBox[shelf]}',
                  color: CustomColor.black,
                  context: context,
                  fontSize: 16);
            },
            itemCount: positionSmallBox.keys.length,
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            CustomAppBar(
              isHome: false,
            ),
            CustomSizedBox(
              context: context,
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: 'ID Order: ',
                    color: CustomColor.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                CustomText(
                  text: '#' + data.id.toString(),
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
                    text: 'Expired Date: ',
                    color: CustomColor.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                CustomText(
                  text: 'Expired date: ' +
                      DateFormat('dd/MM/yyyy').format(
                          dateFormater.parse(data.expiredDate.split('T')[0])),
                  color: CustomColor.black,
                  context: context,
                  fontSize: 16,
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
                  text: oCcy.format(data.total) + ' VND',
                  color: CustomColor.purple,
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
                    text: 'Months: ',
                    color: CustomColor.black,
                    context: context,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
                CustomText(
                  text: data.months.toString(),
                  color: CustomColor.purple,
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
            BoxInfoBillWidget(
              deviceSize: deviceSize,
              imagePath: 'assets/images/smallBox.png',
              price: oCcy.format(data.smallBoxPrice) + ' VND',
              size: '0.5m x 1m x 1m',
              amount: data.smallBoxQuantity,
            ),
            if (data.status != 1)
              _buildPosition(
                  position: positionSmallBox,
                  deviceSize: deviceSize,
                  context: context),
            CustomSizedBox(
              context: context,
              height: 40,
            ),
            BoxInfoBillWidget(
              deviceSize: deviceSize,
              imagePath: 'assets/images/largeBox.png',
              price: oCcy.format(data.bigBoxPrice) + ' VND',
              size: '1m x 1m x 1m',
              amount: data.bigBoxQuantity,
            ),
            if (data.status != 1)
              _buildPosition(
                  position: positionLargeBox,
                  deviceSize: deviceSize,
                  context: context),
            CustomSizedBox(
              context: context,
              height: 24,
            ),
            InfoCall(
                role: 'Customer',
                deviceSize: deviceSize,
                phone: data.customerPhone,
                avatar: data.customerAvatar,
                name: data.customerName),
            CustomSizedBox(
              context: context,
              height: 36,
            ),
          ],
        ),
      ),
    );
  }
}
