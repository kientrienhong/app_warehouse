import 'package:app_warehouse/common/box_input_price.dart';
import 'package:app_warehouse/common/custom_button.dart';
import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_input.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class CreateStorageScreen extends StatefulWidget {
  @override
  _CreateStorageScreenState createState() => _CreateStorageScreenState();
}

class _CreateStorageScreenState extends State<CreateStorageScreen> {
  final _focusNodeLargeBox = FocusNode();
  final _focusNodeSize = FocusNode();
  final _focusName = FocusNode();
  final _focusAddress = FocusNode();
  final _focusPriceSmallBox = FocusNode();
  final _focusAmountShelves = FocusNode();

  final _controllerPriceLargeBox = TextEditingController();
  final _controllerSize = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerAddress = TextEditingController();
  final _controllerPriceSmallBox = TextEditingController();
  final _controllerAmountShelves = TextEditingController();

  double get _largeBoxPrice => double.parse(_controllerPriceLargeBox.text);
  String get _size => _controllerSize.text;
  String get _name => _controllerName.text;
  String get _address => _controllerAddress.text;
  int get _amountShelves => int.parse(_controllerAmountShelves.text);
  double get _priceSmallBox => double.parse(_controllerPriceSmallBox.text);

  List<String> imagePaths = [
    'assets/images/storage1.png',
    'assets/images/storage2.png',
    'assets/images/storage3.png',
    'assets/images/storage4.png',
  ];

  List<String> paperworkPaths = [
    'assets/images/paperwork1.png',
    'assets/images/paperwork2.png',
  ];

  _buildGridView({@required List<String> path, @required Size deviceSize}) {
    return Container(
      height:
          path.length >= 3 ? deviceSize.height / 2.7 : deviceSize.height / 5.4,
      child: GridView.builder(
          physics: ScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
              mainAxisSpacing: 8),
          itemCount: path.length == 6 ? path.length : path.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == path.length) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: DottedBorder(
                  color: CustomColor.black[2],
                  strokeWidth: 1,
                  dashPattern: [8, 4],
                  child: Center(
                    child: Container(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        'assets/images/plus.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            }

            return Image.asset(
              path[index],
              fit: BoxFit.cover,
            );
          }),
    );
  }

  bool _isAgree = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNodeLargeBox.dispose();
    _focusNodeSize.dispose();
    _focusName.dispose();
    _focusPriceSmallBox.dispose();
    _focusAddress.dispose();
    _focusAmountShelves.dispose();

    _controllerPriceLargeBox.dispose();
    _controllerSize.dispose();
    _controllerName.dispose();
    _controllerAddress.dispose();
    _controllerPriceSmallBox.dispose();
    _controllerAmountShelves.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        children: [
          CustomSizedBox(context: context, height: 16),
          CustomText(
            text: 'Storage Infomation',
            color: CustomColor.black,
            context: context,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          CustomSizedBox(context: context, height: 24),
          CustomOutLineInput(
              focusNode: _focusName,
              isDisable: false,
              deviceSize: deviceSize,
              controller: _controllerName,
              nextNode: _focusAddress,
              labelText: 'Name'),
          CustomOutLineInput(
              focusNode: _focusAddress,
              isDisable: false,
              deviceSize: deviceSize,
              controller: _controllerAddress,
              nextNode: _focusNodeSize,
              labelText: 'Address'),
          CustomOutLineInput(
              focusNode: _focusNodeSize,
              isDisable: false,
              deviceSize: deviceSize,
              controller: _controllerSize,
              nextNode: _focusNodeSize,
              textInputType: TextInputType.number,
              labelText: 'Size'),
          CustomText(
            text: 'Gallery',
            color: CustomColor.black,
            context: context,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          CustomSizedBox(context: context, height: 16),
          _buildGridView(deviceSize: deviceSize, path: imagePaths),
          CustomSizedBox(context: context, height: 16),
          CustomText(
            text: 'Paperworker',
            color: CustomColor.black,
            context: context,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          CustomSizedBox(context: context, height: 16),
          _buildGridView(deviceSize: deviceSize, path: paperworkPaths),
          CustomSizedBox(context: context, height: 16),
          CustomText(
            text: 'You must use these items for managing storage',
            color: CustomColor.black,
            context: context,
            textAlign: TextAlign.center,
            maxLines: 2,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          CustomSizedBox(context: context, height: 16),
          Container(
            width: deviceSize.width / 2,
            height: deviceSize.width / 2,
            child: Image.asset(
              'assets/images/shelf.png',
              fit: BoxFit.contain,
            ),
          ),
          CustomSizedBox(context: context, height: 16),
          Container(
            width: double.infinity,
            child: CustomText(
              text: '2880 x 1100 x 4000mm',
              color: CustomColor.black,
              context: context,
              textAlign: TextAlign.center,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          CustomSizedBox(context: context, height: 16),
          Row(
            children: [
              Container(
                width: deviceSize.width / 3 - 12,
              ),
              Container(
                width: deviceSize.width / 3,
                child: CustomOutLineInput(
                  isDisable: false,
                  focusNode: _focusAmountShelves,
                  deviceSize: deviceSize,
                  labelText: 'Amount',
                  controller: _controllerAmountShelves,
                  nextNode: _focusPriceSmallBox,
                ),
              ),
            ],
          ),
          CustomSizedBox(context: context, height: 16),
          BoxInputPrice(
              deviceSize: deviceSize,
              context: context,
              imagePath: 'assets/images/smallBox.png',
              size: '0.5m x 1m x 1m',
              controller: _controllerPriceSmallBox,
              nodeCurrent: _focusPriceSmallBox,
              nextNode: _focusNodeLargeBox),
          CustomSizedBox(context: context, height: 16),
          BoxInputPrice(
            deviceSize: deviceSize,
            context: context,
            imagePath: 'assets/images/largeBox.png',
            size: '1m x 1m x 1m',
            controller: _controllerPriceLargeBox,
            nodeCurrent: _focusNodeLargeBox,
          ),
          CustomSizedBox(context: context, height: 16),
          Row(
            children: [
              CustomText(
                text: 'Do you agree?',
                color: CustomColor.black,
                context: context,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              CustomSizedBox(
                context: context,
                width: 8,
              ),
              Checkbox(
                  value: _isAgree,
                  onChanged: (bool value) {
                    setState(() {
                      _isAgree = value;
                    });
                  }),
            ],
          ),
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          CustomButton(
              height: 32,
              text: 'Submit',
              width: double.infinity,
              textColor:
                  _isAgree == true ? CustomColor.green : CustomColor.black,
              onPressFunction: _isAgree == true ? () {} : null,
              buttonColor: _isAgree == true
                  ? CustomColor.lightBlue
                  : CustomColor.black[3],
              borderRadius: 4),
          CustomSizedBox(
            context: context,
            height: 80,
          ),
        ],
      ),
    );
  }
}
