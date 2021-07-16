import 'package:appwarehouse/common/custom_button.dart';
import 'package:appwarehouse/common/custom_input.dart';
import 'package:appwarehouse/common/custom_msg_input.dart';
import 'package:appwarehouse/models/entity/order_customer.dart';
import 'package:appwarehouse/models/entity/storage.dart';
import 'package:appwarehouse/models/entity/user.dart';
import 'package:appwarehouse/pages/owner_screens/detail_storage/owner_detail_storage.dart';
import 'package:appwarehouse/presenters/detail_bill_screen.dart';
import 'package:appwarehouse/views/detail_bill_view.dart';
import 'package:flutter/cupertino.dart';

import '/common/box_info_bill_widget.dart';
import '/common/custom_app_bar.dart';
import '/common/custom_color.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import '/common/info_call.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailBillScreen extends StatefulWidget {
  final OrderCustomer data;

  DetailBillScreen({this.data});

  @override
  State<DetailBillScreen> createState() => _DetailBillScreenState();
}

class _DetailBillScreenState extends State<DetailBillScreen>
    implements DetailBillView {
  DateFormat dateFormater = DateFormat('yyyy-MM-dd');
  DetailBillScreenPresenter presenter;
  final oCcy = new NumberFormat("#,##0", "en_US");
  TextEditingController controller;
  FocusNode focusNode;

  Widget _buildPosition(
      {@required Map<String, dynamic> position,
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
              String shelf = position.keys.toList()[index];

              return CustomText(
                  text: '$shelf - ${position[shelf]}',
                  color: CustomColor.black,
                  context: context,
                  fontSize: 16);
            },
            itemCount: position.keys.length,
          )),
        ],
      ),
    );
  }

  Widget _buildCheckOut(Size deviceSize) {
    return Column(
      children: [
        CustomMsgInput(
            msg: presenter.model.msg,
            isError: presenter.model.isError,
            maxLines: 1),
        CustomSizedBox(
          context: context,
          height: 4,
        ),
        CustomButton(
            height: 32,
            text: 'Check out',
            width: double.infinity,
            isLoading: presenter.model.isLoading,
            textColor: CustomColor.green,
            onPressFunction: () => handleOnClickWithoutReason(),
            buttonColor: CustomColor.lightBlue,
            borderRadius: 4),
      ],
    );
  }

  @override
  void updateLoading() {
    setState(() {
      presenter.model.isLoading = !presenter.model.isLoading;
    });
  }

  @override
  void updateLoadingStorage() {
    setState(() {
      presenter.model.isLoadingStorage = !presenter.model.isLoadingStorage;
    });
  }

  @override
  void updateMsg(String msg, bool isError) {
    setState(() {
      presenter.model.msg = msg;
      presenter.model.isError = isError;
    });
  }

  _showDialogDialog(Size deviceSize) {
    String msg = '';
    bool isError = false;
    bool isLoading = false;
    showDialog(
        context: context,
        builder: (_) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                content: Container(
                    height: deviceSize.height / 3.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                            text: 'Return item to customers',
                            color: CustomColor.purple,
                            fontWeight: FontWeight.bold,
                            context: context,
                            fontSize: 20),
                        CustomSizedBox(
                          context: context,
                          height: 24,
                        ),
                        CustomOutLineInput(
                            isDisable: false,
                            focusNode: focusNode,
                            controller: controller,
                            deviceSize: deviceSize,
                            labelText: 'Reason'),
                        CustomMsgInput(msg: msg, isError: isError, maxLines: 1),
                        CustomSizedBox(
                          context: context,
                          height: 4,
                        ),
                        CustomButton(
                          height: 32,
                          text: 'Check out',
                          width: double.infinity,
                          isLoading: isLoading,
                          borderRadius: 4,
                          buttonColor: CustomColor.lightBlue,
                          textColor: CustomColor.green,
                          onPressFunction: () async {
                            {
                              User user =
                                  Provider.of<User>(context, listen: false);

                              setState(() {
                                isLoading = true;
                              });

                              if (presenter.model.isAlreadyCheckOut == true) {
                                setState(() {
                                  msg = 'You already check out';
                                  isError = false;
                                  isLoading = false;
                                });
                                return;
                              }

                              if (controller.text.isEmpty) {
                                setState(() {
                                  msg = 'You must provide reason';
                                  isError = true;
                                  isLoading = false;
                                });
                                return;
                              }
                              bool response = await presenter.handleOnClick(
                                  user.jwtToken,
                                  widget.data.id,
                                  controller.text);

                              if (response == true) {
                                setState(() {
                                  msg = 'Success Remove';
                                  isError = false;
                                });
                              }

                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                        )
                      ],
                    )),
              ),
            ));
  }

  @override
  void handleOnClickWithReason(String msg, bool isError, bool isLoading) {}

  @override
  void handleOnClickGoToStorage() async {
    User user = Provider.of<User>(context, listen: false);
    var result = await presenter.handleOnClickGoToStorage(
        user.jwtToken, widget.data.storageId);
    Storage currentStorage = Provider.of<Storage>(context, listen: false);
    currentStorage.setStorage(result);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => OwnerDetailStorage(
                  data: result,
                )));
  }

  @override
  void handleOnClickWithoutReason() {
    User user = Provider.of<User>(context, listen: false);

    if (presenter.model.isAlreadyCheckOut == true) {
      updateMsg('You already check out', false);
      return;
    }

    if (widget.data.status == 2) {
      if (controller.text.isEmpty) {
        updateMsg('You must provide reason', true);
        return;
      }
      presenter.handleOnClick(user.jwtToken, widget.data.id, controller.text);
    } else {
      presenter.handleOnClick(user.jwtToken, widget.data.id, null);
    }
  }

  @override
  void initState() {
    super.initState();
    presenter = DetailBillScreenPresenter();
    presenter.view = this;
    presenter.formatData(widget.data.boxUsed);
    controller = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    focusNode.dispose();
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
            if (widget.data.status == 4 || widget.data.status == 2)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => _showDialogDialog(deviceSize),
                    child: Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: CustomColor.purple, width: 1),
                            borderRadius: BorderRadius.circular(4)),
                        child: Image.asset('assets/images/danger.png',
                            fit: BoxFit.cover)),
                  )
                ],
              ),
            CustomSizedBox(
              context: context,
              height: 8,
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
                  text: '#' + widget.data.id.toString(),
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
                      DateFormat('dd/MM/yyyy').format(dateFormater
                          .parse(widget.data.expiredDate.split('T')[0])),
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
                  text: oCcy.format(widget.data.total) + ' VND',
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
                  text: widget.data.months.toString(),
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
              price: oCcy.format(widget.data.smallBoxPrice) + ' VND',
              size: '0.5m x 1m x 1m',
              amount: widget.data.smallBoxQuantity,
            ),
            if (widget.data.status != 1)
              _buildPosition(
                  position: presenter.model.positionSmallBox,
                  deviceSize: deviceSize,
                  context: context),
            CustomSizedBox(
              context: context,
              height: 40,
            ),
            BoxInfoBillWidget(
              deviceSize: deviceSize,
              imagePath: 'assets/images/largeBox.png',
              price: oCcy.format(widget.data.bigBoxPrice) + ' VND',
              size: '1m x 1m x 1m',
              amount: widget.data.bigBoxQuantity,
            ),
            if (widget.data.status != 1)
              _buildPosition(
                  position: presenter.model.positionLargeBox,
                  deviceSize: deviceSize,
                  context: context),
            CustomSizedBox(
              context: context,
              height: 24,
            ),
            InfoCall(
                role: 'Customer',
                deviceSize: deviceSize,
                phone: widget.data.customerPhone,
                avatar: widget.data.customerAvatar,
                name: widget.data.customerName),
            CustomSizedBox(context: context, height: 24),
            if (widget.data.status == 4) _buildCheckOut(deviceSize),
            if (widget.data.status == 4 || widget.data.status == 2)
              CustomButton(
                  height: 32,
                  text: 'Go to storage',
                  width: double.infinity,
                  isLoading: presenter.model.isLoadingStorage,
                  textColor: CustomColor.white,
                  onPressFunction: () {
                    handleOnClickGoToStorage();
                  },
                  buttonColor: CustomColor.purple,
                  borderRadius: 4),
            CustomSizedBox(
              context: context,
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
