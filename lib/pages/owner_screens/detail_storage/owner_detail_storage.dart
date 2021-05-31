import 'package:app_warehouse/common/box_input_price.dart';
import 'package:app_warehouse/common/custom_app_bar.dart';
import 'package:app_warehouse/common/custom_button.dart';
import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:app_warehouse/pages/owner_screens/detail_storage/status_shelf.dart';
import 'package:flutter/material.dart';

class OwnerDetailStorage extends StatefulWidget {
  @override
  _OwnerDetailStorageState createState() => _OwnerDetailStorageState();
}

class _OwnerDetailStorageState extends State<OwnerDetailStorage> {
  TextEditingController _priceSmallBoxController;
  TextEditingController _priceLargeBoxController;
  double get _priceSmallBox => double.parse(_priceSmallBoxController.text);
  double get _priceLargeBox => double.parse(_priceLargeBoxController.text);
  FocusNode _priceSmallBoxFocusNode;
  FocusNode _priceLargeBoxFocusNode;
  List<Map<String, dynamic>> dataShelves;
  @override
  void initState() {
    super.initState();
    _priceSmallBoxController = TextEditingController();
    _priceLargeBoxController = TextEditingController();
    _priceSmallBoxFocusNode = FocusNode();
    _priceLargeBoxFocusNode = FocusNode();
    dataShelves = [
      {
        'name': 'Shelf - 1',
        'percent': 80,
        'listBox': [
          {
            'orderId': 'R001',
            'type': 'large',
            'position': 'B1',
            'timeRemain': '1 Month - 1 Week - 4 Days'
          },
          {
            'orderId': 'R001',
            'type': 'small',
            'position': 'A4',
            'timeRemain': '1 Month - 1 Week - 4 Days'
          },
          {
            'orderId': 'R002',
            'type': 'large',
            'position': 'A1',
            'timeRemain': '1 Week - 4 Days'
          },
          {
            'orderId': 'R002',
            'type': 'small',
            'position': 'A3',
            'timeRemain': '1 Week - 4 Days'
          }
        ]
      },
      {
        'name': 'Shelf - 2',
        'percent': 40,
      },
      {
        'name': 'Shelf - 3',
        'percent': 100,
      },
      {
        'name': 'Shelf - 4',
        'percent': 0,
      },
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _priceSmallBoxController.dispose();
    _priceLargeBoxController.dispose();
    _priceSmallBoxFocusNode.dispose();
    _priceLargeBoxFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            CustomAppBar(
              isHome: false,
            ),
            CustomSizedBox(
              context: context,
              height: 24,
            ),
            CustomText(
                text: 'Boxes',
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 24),
            CustomSizedBox(
              context: context,
              height: 24,
            ),
            BoxInputPrice(
              deviceSize: deviceSize,
              context: context,
              imagePath: 'assets/images/smallBox.png',
              size: '0.5m x 1m x 1m',
              controller: _priceSmallBoxController,
              nodeCurrent: _priceSmallBoxFocusNode,
              nextNode: _priceLargeBoxFocusNode,
            ),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            BoxInputPrice(
              deviceSize: deviceSize,
              context: context,
              imagePath: 'assets/images/largeBox.png',
              size: '1m x 1m x 1m',
              controller: _priceLargeBoxController,
              nodeCurrent: _priceLargeBoxFocusNode,
            ),
            CustomSizedBox(
              context: context,
              height: 24,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              CustomText(
                color: CustomColor.black,
                context: context,
                fontSize: 24,
                text: 'Shelves',
                fontWeight: FontWeight.bold,
              ),
              Container(
                child: ImageIcon(
                  AssetImage('assets/images/plus.png'),
                  color: CustomColor.purple,
                ),
              )
            ]),
            CustomSizedBox(
              context: context,
              height: 8,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_, index) {
                return StatusShelf(
                  deviceSize: deviceSize,
                  data: dataShelves[index],
                );
              },
              itemCount: dataShelves.length,
            ),
            CustomSizedBox(
              context: context,
              height: 24,
            ),
            CustomButton(
                height: 32,
                text: 'Submit',
                width: double.infinity,
                textColor: CustomColor.green,
                onPressFunction: () {},
                buttonColor: CustomColor.lightBlue,
                borderRadius: 4),
            CustomSizedBox(
              context: context,
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
