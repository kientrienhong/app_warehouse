import 'package:app_warehouse/common/custom_app_bar.dart';
import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_input.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:flutter/material.dart';

class OwnerDetailStorage extends StatefulWidget {
  @override
  _OwnerDetailStorageState createState() => _OwnerDetailStorageState();
}

class _OwnerDetailStorageState extends State<OwnerDetailStorage> {
  Widget _buildBox(
      {@required Size deviceSize,
      @required BuildContext context,
      @required String imagePath,
      @required String size,
      @required TextEditingController controller,
      @required FocusNode nodeCurrent,
      @required FocusNode nextNode}) {
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

  TextEditingController _priceSmallBoxController;
  TextEditingController _priceLargeBoxController;
  double get _priceSmallBox => double.parse(_priceSmallBoxController.text);
  double get _priceLargeBox => double.parse(_priceLargeBoxController.text);
  FocusNode _priceSmallBoxFocusNode;
  FocusNode _priceLargeBoxFocusNode;

  @override
  void initState() {
    super.initState();
    _priceSmallBoxController = TextEditingController();
    _priceLargeBoxController = TextEditingController();
    _priceSmallBoxFocusNode = FocusNode();
    _priceLargeBoxFocusNode = FocusNode();
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
            _buildBox(
                deviceSize: deviceSize,
                context: context,
                imagePath: 'assets/images/smallBox.png',
                size: '0.5m x 1m x 1m',
                controller: _priceSmallBoxController,
                nodeCurrent: _priceSmallBoxFocusNode,
                nextNode: _priceLargeBoxFocusNode),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            _buildBox(
                deviceSize: deviceSize,
                context: context,
                imagePath: 'assets/images/largeBox.png',
                size: '1m x 1m x 1m',
                controller: _priceLargeBoxController,
                nodeCurrent: _priceLargeBoxFocusNode,
                nextNode: null),
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
          ],
        ),
      ),
    );
  }
}
