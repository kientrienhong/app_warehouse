import 'package:appwarehouse/api/api_services.dart';
import 'package:appwarehouse/common/custom_button.dart';
import 'package:appwarehouse/common/custom_msg_input.dart';
import 'package:appwarehouse/models/entity/storage.dart';
import 'package:appwarehouse/models/entity/user.dart';
import 'package:appwarehouse/pages/owner_screens/choose_storage/choose_storage_screen.dart';
import 'package:appwarehouse/presenters/feedback_presenter.dart';
import 'package:appwarehouse/views/feedback_view.dart';

import '/models/entity/order.dart';

import '/common/bill_info_widget.dart';
import '/common/box_info_bill_widget.dart';
import '/common/custom_color.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import '/common/info_call.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class BillWidget extends StatelessWidget {
  Order data;
  final oCcy = new NumberFormat("#,##0", "en_US");
  DateFormat dateFormater = DateFormat('yyyy-MM-dd');
  BillWidget({
    this.data,
  });

  void callDetailOrder(BuildContext context) async {
    String jwt =
        'eyJhbGciOiJSUzI1NiIsImtpZCI6IjhmNDMyMDRhMTc5MTVlOGJlN2NjZDdjYjI2NGRmNmVhMzgzYzQ5YWIiLCJ0eXAiOiJKV1QifQ.eyJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJPd25lciIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS93YWZheXUtODI3NTMiLCJhdWQiOiJ3YWZheXUtODI3NTMiLCJhdXRoX3RpbWUiOjE2MjU5MDI4OTUsInVzZXJfaWQiOiI5SE5vY0diZjhkY29URE9Fd1E4aTRNMFFLQ2cyIiwic3ViIjoiOUhOb2NHYmY4ZGNvVERPRXdROGk0TTBRS0NnMiIsImlhdCI6MTYyNTkwMjg5NSwiZXhwIjoxNjI1OTA2NDk1LCJlbWFpbCI6Im93bmVyMzIxM0BnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsib3duZXIzMjEzQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.V_nlNyb5rDHg0jiU71DIEujfN37WoECFnNC_iA6faL8yKXgzie1iRYmS5YobmIHbefIB0v6eQsu2146E4G_Q692-_Xry11IzxQU7ACXFPoTcEp_8jlTHVDrbwhQKDpgMc5U68bLUwAHyC-rqEMXzT1_nEe78XuuCHYRwly-2s2JH3eG0cynsGbOHwWiQQBWgL-e1AE8Xxobwy8Sg5_PP8K9O-wuXTx1jCL3OonIi0dzrxYFIWxH2g7h-1AtT6AcLvHXxiVbkJp3XGi7IroTfw-xG-F3d4YD76Lxi3Ru3FLEgou3VMpV8s-AejRz9KL042T3eNJUMNeuWjyJ_midF3Q';
    var resultOrder = await ApiServices.getOrder(jwt, data.id);
    Order order = Provider.of<Order>(context, listen: false);
    order.setOrder(Order.fromMap(resultOrder.data));
    var resultStorage = await ApiServices.getStorage(jwt, order.idStorage);
    Storage storage = Provider.of<Storage>(context, listen: false);
    storage.setStorage(Storage.fromMap(resultStorage.data));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ChooseStorageScreen(
                  isImported: true,
                  idPreviousStorage: storage.id,
                  order: order,
                )));
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          BillInfoWidget(
            data: data,
          ),
          if (data.smallBoxQuantity > 0)
            CustomSizedBox(
              context: context,
              height: 40,
            ),
          if (data.smallBoxQuantity > 0)
            BoxInfoBillWidget(
                deviceSize: deviceSize,
                price: '${oCcy.format(data.smallBoxPrice)} VND',
                imagePath: 'assets/images/smallBox.png',
                amount: data.smallBoxQuantity,
                size: '0.5m x 1m x 2m'),
          CustomSizedBox(
            context: context,
            height: 32,
          ),
          if (data.bigBoxQuantity > 0)
            BoxInfoBillWidget(
                deviceSize: deviceSize,
                price: '${oCcy.format(data.bigBoxPrice)} VND',
                imagePath: 'assets/images/largeBox.png',
                amount: data.bigBoxQuantity,
                size: '1m x 1m x 2m'),
          if (data.bigBoxQuantity > 0)
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
          GestureDetector(
            onTap: () => callDetailOrder(context),
            child: QrImage(
              data: data.id.toString(),
              size: 88.0,
              version: 2,
            ),
          ),
          CustomSizedBox(
            context: context,
            height: 8,
          ),
          if (data.expiredDate != null)
            CustomText(
              text:
                  'Expired date: ${DateFormat('dd/MM/yyyy').format(dateFormater.parse(data.expiredDate.split('T')[0]))}',
              color: CustomColor.black[1],
              context: context,
              fontSize: 16,
            ),
          CustomSizedBox(
            context: context,
            height: 8,
          ),
          if (data.status != 1)
            FeedbackWidget(
              data: data,
            )
        ],
      ),
    );
  }
}

class FeedbackWidget extends StatefulWidget {
  Order data;
  FeedbackWidget({this.data});

  @override
  _FeedbackWidgetState createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget>
    implements FeedbackView {
  TextEditingController _controller;
  FeedbackPresenter _presenter;
  double _rating;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _presenter = FeedbackPresenter();
    _presenter.view = this;
    if (widget.data != null) {
      _controller.text = widget.data.comment;
    }
  }

  @override
  void updateLoading() {
    setState(() {
      _presenter.model.isLoading = !_presenter.model.isLoading;
    });
  }

  @override
  void updateMsg(String msg, bool isError) {
    setState(() {
      _presenter.model.msg = msg;
      _presenter.model.isError = isError;
    });
  }

  @override
  void handleOnClickFeedback(
      int idStorage, int idOrder, String comment, double rating) {
    User user = Provider.of<User>(context, listen: false);
    if (widget.data.rating == null) {
      _presenter.onHandleAddFeedback(
          idStorage, idOrder, comment, rating, user.jwtToken);
      widget.data = widget.data.copyWith(rating: rating);
    } else {
      _presenter.onHandleUpdateFeedback(
          idStorage, idOrder, comment, rating, user.jwtToken);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: CustomColor.purple, width: 1),
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                    text: 'Your rating',
                    color: CustomColor.black,
                    context: context,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                CustomSizedBox(
                  context: context,
                  height: 8,
                ),
                RatingBar.builder(
                  initialRating:
                      widget.data.rating == null ? 0 : widget.data.rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.only(right: 4),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 16,
                  ),
                  onRatingUpdate: (rating) {
                    _rating = rating;
                  },
                ),
                CustomSizedBox(
                  context: context,
                  height: 8,
                ),
                TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                      hintText: 'Your comment...',
                      fillColor: Colors.white,
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none),
                ),
                CustomSizedBox(
                  context: context,
                  height: 4,
                ),
                if (_presenter.model.msg.length > 0)
                  CustomMsgInput(
                      msg: _presenter.model.msg,
                      isError: _presenter.model.isError,
                      maxLines: 1),
                CustomSizedBox(
                  context: context,
                  height: 4,
                ),
                CustomButton(
                    height: 32,
                    text: 'Comment',
                    width: double.infinity,
                    isLoading: _presenter.model.isLoading,
                    textColor: CustomColor.green,
                    onPressFunction: () {
                      handleOnClickFeedback(widget.data.idStorage,
                          widget.data.id, _controller.text, _rating);
                    },
                    buttonColor: CustomColor.lightBlue,
                    borderRadius: 4),
                CustomSizedBox(
                  context: context,
                  height: 16,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
