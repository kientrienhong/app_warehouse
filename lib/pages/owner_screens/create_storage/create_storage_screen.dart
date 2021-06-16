import 'dart:io';

import 'package:app_warehouse/common/box_input_price.dart';
import 'package:app_warehouse/common/custom_app_bar.dart';
import 'package:app_warehouse/common/custom_button.dart';
import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_input.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:app_warehouse/pages/owner_screens/home_screen/owner_home_screen.dart';
import 'package:app_warehouse/presenters/create_storage_presenter.dart';
import 'package:app_warehouse/views/create_storage_view.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';

class CreateStorageScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  CreateStorageScreen({@required this.data});

  @override
  _CreateStorageScreenState createState() => _CreateStorageScreenState();
}

class _CreateStorageScreenState extends State<CreateStorageScreen>
    implements CreateStorageView {
  CreateStoragePresenter presenter;
  var picker;

  @override
  void updateStatusButton(bool isAgree) {
    setState(() {
      presenter.model.isAgree = isAgree;
    });
  }

  @override
  void onClickDeleteGalleryImage(String typeList, int index) {
    presenter.onHanldeDeleteImage(typeList, index);
  }

  @override
  void updateGridView(String typeList, List<File> listFile) {
    setState(() {
      presenter.model.allImage[typeList] = listFile;
    });
  }

  @override
  void onClickEditGalleryImage(String typeList, int index) async {
    PickedFile image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null)
      presenter.onHandleEditImage(typeList, File(image.path), index);
  }

  @override
  void onClickAddGalleryImage(String typeList) async {
    PickedFile image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) presenter.onHandleAddImage(typeList, File(image.path));
  }

  final _focusNodeLargeBox = FocusNode();
  // final _focusNodeSize = FocusNode();
  final _focusName = FocusNode();
  final _focusAddress = FocusNode();
  final _focusPriceSmallBox = FocusNode();
  final _focusAmountShelves = FocusNode();

  final _controllerPriceLargeBox = TextEditingController();
  // final _controllerSize = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerAddress = TextEditingController();
  final _controllerPriceSmallBox = TextEditingController();
  final _controllerAmountShelves = TextEditingController();

  double get _largeBoxPrice => double.parse(_controllerPriceLargeBox.text);
  // String get _size => _controllerSize.text;
  String get _name => _controllerName.text;
  String get _address => _controllerAddress.text;
  int get _amountShelves => int.parse(_controllerAmountShelves.text);
  double get _priceSmallBox => double.parse(_controllerPriceSmallBox.text);

  _buildGridView(
      {@required List<File> listFile,
      @required Size deviceSize,
      @required String typeList}) {
    return Container(
      height: deviceSize.height / 5.4,
      child: GridView.builder(
          physics: ScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
              mainAxisSpacing: 8),
          itemCount:
              listFile.length == 3 ? listFile.length : listFile.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == listFile.length) {
              return GestureDetector(
                onTap: () => onClickAddGalleryImage(typeList),
                child: ClipRRect(
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
                ),
              );
            }

            return GestureDetector(
              onLongPress: () => onClickDeleteGalleryImage(typeList, index),
              onTap: () => onClickEditGalleryImage(typeList, index),
              child: Image.file(
                listFile[index],
                fit: BoxFit.cover,
              ),
            );
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    presenter = CreateStoragePresenter();
    presenter.view = this;
    picker = ImagePicker();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNodeLargeBox.dispose();
    // _focusNodeSize.dispose();
    _focusName.dispose();
    _focusPriceSmallBox.dispose();
    _focusAddress.dispose();
    _focusAmountShelves.dispose();

    _controllerPriceLargeBox.dispose();
    // _controllerSize.dispose();
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
          if (widget.data != null)
            CustomAppBar(
              isHome: false,
            ),
          if (widget.data != null)
            if (widget.data['statusChecking'] == StatusCheckingStorage.Reject)
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CustomText(
                  text: 'Reason',
                  color: CustomColor.red,
                  context: context,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                CustomSizedBox(context: context, height: 16),
                CustomText(
                  text: 'You must provide enough paperworkers',
                  color: CustomColor.red,
                  context: context,
                  fontSize: 16,
                ),
                CustomSizedBox(context: context, height: 16),
              ]),
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
              nextNode: _focusAmountShelves,
              // nextNode: _focusNodeSize,
              labelText: 'Address'),
          // CustomOutLineInput(
          //     focusNode: _focusNodeSize,
          //     isDisable: false,
          //     deviceSize: deviceSize,
          //     controller: _controllerSize,
          //     nextNode: _focusNodeSize,
          //     textInputType: TextInputType.number,
          //     labelText: 'Size'),
          CustomText(
            text: 'Gallery',
            color: CustomColor.black,
            context: context,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          CustomSizedBox(context: context, height: 16),
          _buildGridView(
              deviceSize: deviceSize,
              listFile: presenter.model.allImage['imageStorage'],
              typeList: 'imageStorage'),
          CustomSizedBox(context: context, height: 16),
          CustomText(
            text: 'Paperworker',
            color: CustomColor.black,
            context: context,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          CustomSizedBox(context: context, height: 16),
          _buildGridView(
              deviceSize: deviceSize,
              listFile: presenter.model.allImage['paperStorage'],
              typeList: 'paperStorage'),
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
                value: presenter.model.isAgree,
                onChanged: updateStatusButton,
              )
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
              textColor: presenter.model.isAgree == true
                  ? CustomColor.green
                  : CustomColor.black,
              onPressFunction: presenter.model.isAgree == true ? () {} : null,
              buttonColor: presenter.model.isAgree == true
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
