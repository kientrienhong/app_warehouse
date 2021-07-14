import '/common/custom_msg_input.dart';
import '/models/entity/order.dart';
import '/pages/customer_screens/for_rent_detail/bill_protecting_service.dart';
import '/common/custom_app_bar.dart';
import '/common/custom_color.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import '/common/info_call.dart';
import '/models/entity/storage.dart';
import '/models/entity/user.dart';
import '/presenters/customer_detail_storage_presenter.dart';
import '/views/customer_detail_storage_view.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DetailProtectingServiceScreen extends StatefulWidget {
  final Storage data;

  DetailProtectingServiceScreen({this.data});

  @override
  _DetailProtectingServiceScreenState createState() =>
      _DetailProtectingServiceScreenState();
}

class _DetailProtectingServiceScreenState
    extends State<DetailProtectingServiceScreen>
    implements CustomerDetailStorageView {
  CustomerDetailStoragePresenter presenter;
  final oCcy = new NumberFormat("#,##0", "en_US");
  DateTime selectedDate = DateTime.now();
  DateTime pickedDate;
  @override
  onClickSelectDate(BuildContext context) async {
    pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: selectedDate,
      lastDate: selectedDate.add(Duration(days: 3)),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      DateFormat format = DateFormat('dd/MM/yyyy');
      updateDatePickUp(format.format(pickedDate));
    }
  }

  Widget _buildOptionBox(
      {@required BuildContext context,
      @required Size deviceSize,
      @required String price,
      @required String imagePath,
      @required String value,
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
                GestureDetector(
                    onTap: () => onClickChangeQuantity(value, false),
                    child: Image.asset('assets/images/sub.png')),
                CustomSizedBox(
                  context: context,
                  width: 8,
                ),
                CustomText(
                  text: presenter.model.quantities[value].toString(),
                  color: CustomColor.purple,
                  context: context,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                CustomSizedBox(
                  context: context,
                  width: 8,
                ),
                GestureDetector(
                  onTap: () => onClickChangeQuantity(value, true),
                  child: Image.asset('assets/images/plus.png'),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  List<Widget> _buildListImageWidget(
      List<dynamic> listImages, Size deviceSize) {
    return listImages.where((element) => element['type'] == 0).map((element) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: deviceSize.width,
          height: deviceSize.height / 4.8,
          child: Image.network(element['imageUrl'], fit: BoxFit.cover),
        ),
      );
    }).toList();
  }

  @override
  void onClickPayment(int idStorage) async {
    if (presenter.model.totalPrice == 0) {
      updateMsg(true, 'Please book something');
      return;
    }
    User user = Provider.of<User>(context, listen: false);
    var request = BraintreeDropInRequest(
        tokenizationKey: 'sandbox_x62jjpjk_n5rdrcwx7kv3ppb7',
        collectDeviceData: true,
        paypalRequest: BraintreePayPalRequest(
            currencyCode: 'VND',
            amount: presenter.model.totalPrice.toString(),
            displayName: user.name));

    BraintreeDropInResult result = await BraintreeDropIn.start(request);
    if (result != null) {
      var response =
          await presenter.checkOut(idStorage, user.jwtToken, pickedDate);
      if (response != null) {
        Order order = Order(
          id: response['id'],
          total: presenter.model.totalPrice,
          ownerAvatar: widget.data.ownerAvatar,
          address: widget.data.address,
          bigBoxPrice: widget.data.priceTo,
          bigBoxQuantity: presenter.model.quantities['amountBigBox'],
          month: presenter.model.quantities['months'],
          name: widget.data.name,
          ownerName: widget.data.ownerName,
          ownerPhone: widget.data.ownerPhone,
          smallBoxPrice: widget.data.priceFrom,
          smallBoxQuantity: presenter.model.quantities['amountSmallBox'],
          status: response['status'],
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (ctx) => BillProtectingService(
                      data: order,
                    )));
      }
    } else {
      updateMsg(true, 'Paid fail');
    }
  }

  @override
  void updateDatePickUp(String newDate) {
    setState(() {
      presenter.model.datePickUp = newDate;
    });
  }

  @override
  void updateMsg(bool isError, String msg) {
    setState(() {
      presenter.model.isError = isError;
      presenter.model.msg = msg;
    });
  }

  @override
  void updateLoading() {
    setState(() {
      presenter.model.isLoading = !presenter.model.isLoading;
    });
  }

  @override
  void updateQuantity(Map<String, int> value, double totalPrice) {
    setState(() {
      presenter.model.quantities = value;
      presenter.model.totalPrice = totalPrice;
    });
  }

  @override
  void onClickChangeQuantity(String value, bool isIncrease) {
    presenter.onHandleChangeQuantity(value, isIncrease);
  }

  @override
  void initState() {
    super.initState();
    presenter = CustomerDetailStoragePresenter(
        priceFrom: widget.data.priceFrom, priceTo: widget.data.priceTo);
    presenter.view = this;
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: deviceSize.width,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                isHome: false,
              ),
              CustomSizedBox(
                context: context,
                height: 24,
              ),
              CarouselSlider(
                  items: _buildListImageWidget(widget.data.picture, deviceSize),
                  options: CarouselOptions(
                    height: deviceSize.height / 4.8,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    reverse: false,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  )),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: widget.data.name,
                      color: CustomColor.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ],
              ),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              CustomText(
                text: widget.data.address,
                color: CustomColor.black[2],
                context: context,
                fontSize: 14,
                maxLines: 2,
              ),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              RatingBarIndicator(
                rating:
                    widget.data.rating == null ? 0 : widget.data.rating * 1.0,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Color(0xFFFFCC1F),
                ),
                itemCount: 5,
                itemSize: 18,
                direction: Axis.horizontal,
              ),
              CustomSizedBox(
                context: context,
                height: 24,
              ),
              CustomText(
                  text: 'Description',
                  color: CustomColor.black,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              CustomText(
                  text: widget.data.description,
                  color: CustomColor.black[2],
                  context: context,
                  textAlign: TextAlign.justify,
                  maxLines: 7,
                  fontSize: 14),
              CustomSizedBox(
                context: context,
                height: 24,
              ),
              InfoCall(
                avatar: widget.data.ownerAvatar,
                deviceSize: deviceSize,
                name: widget.data.ownerName,
                phone: widget.data.ownerPhone,
                role: 'Owner',
              ),
              CustomSizedBox(
                context: context,
                height: 40,
              ),
              _buildOptionBox(
                  value: 'amountSmallBox',
                  context: context,
                  size: '0.5m x 1m x 2m',
                  deviceSize: deviceSize,
                  price: '${oCcy.format(widget.data.priceFrom)} VND',
                  imagePath: 'assets/images/smallBox.png'),
              CustomSizedBox(
                context: context,
                height: 40,
              ),
              _buildOptionBox(
                  value: 'amountBigBox',
                  context: context,
                  size: '1m x 1m x 2m',
                  deviceSize: deviceSize,
                  price: '${oCcy.format(widget.data.priceTo)} VND',
                  imagePath: 'assets/images/largeBox.png'),
              CustomSizedBox(
                context: context,
                height: 32,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                      text: 'Months: ',
                      color: CustomColor.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                  Container(
                    width: 32,
                    height: 32,
                    child: TextButton(
                      onPressed: () => onClickChangeQuantity('months', false),
                      child: Image.asset('assets/images/sub.png',
                          fit: BoxFit.cover),
                    ),
                  ),
                  CustomText(
                    text: presenter.model.quantities['months'].toString(),
                    color: CustomColor.purple,
                    context: context,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    child: TextButton(
                        onPressed: () => onClickChangeQuantity('months', true),
                        child: Image.asset('assets/images/plus.png',
                            fit: BoxFit.cover)),
                  ),
                ],
              ),
              CustomSizedBox(
                context: context,
                height: 32,
              ),
              Row(
                children: [
                  CustomText(
                    text: 'Date pick up: ',
                    color: CustomColor.black,
                    context: context,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomSizedBox(
                    context: context,
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () => onClickSelectDate(context),
                    child: Container(
                        width: 24,
                        height: 24,
                        child: Image.asset(
                          'assets/images/calendar.png',
                          fit: BoxFit.cover,
                        )),
                  ),
                  CustomSizedBox(
                    context: context,
                    width: 8,
                  ),
                  CustomText(
                      text: '${presenter.model.datePickUp}',
                      color: CustomColor.purple,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ],
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              Row(
                children: [
                  CustomText(
                    text: 'Price: ',
                    color: CustomColor.black,
                    context: context,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomSizedBox(
                    context: context,
                    width: 8,
                  ),
                  CustomText(
                      text: '${oCcy.format(presenter.model.totalPrice)} VND',
                      color: CustomColor.purple,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ],
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              if (presenter.model.msg.length > 0)
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CustomMsgInput(
                      msg: presenter.model.msg,
                      isError: presenter.model.isError,
                      maxLines: 1),
                ]),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: CustomColor.lightBlue),
                  child: TextButton(
                      onPressed: presenter.model.isLoading == false
                          ? () async {
                              onClickPayment(widget.data.id);
                            }
                          : () {},
                      child: presenter.model.isLoading == false
                          ? Image.asset('assets/images/paypal.png')
                          : SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ))),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
