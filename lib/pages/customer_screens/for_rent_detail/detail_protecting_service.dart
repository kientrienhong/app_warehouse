import 'package:app_warehouse/common/custom_app_bar.dart';
import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:app_warehouse/models/entity/storage.dart';
import 'package:app_warehouse/presenters/customer_detail_storage_presenter.dart';
import 'package:app_warehouse/views/customer_detail_storage_view.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

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
    // TODO: implement initState
    super.initState();
    presenter = CustomerDetailStoragePresenter(
        // priceFrom: widget.data.priceFrom, priceTo: widget.data.priceTo);
        priceFrom: 12000,
        priceTo: 20000);
    presenter.view = this;
  }

  @override
  Widget build(BuildContext context) {
    final Size deviceSize = MediaQuery.of(context).size;
    final String description =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';
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
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: deviceSize.width,
                  height: deviceSize.height / 4.8,
                  child: Image.network(widget.data.picture, fit: BoxFit.cover),
                ),
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: widget.data.name == null
                          ? 'Storage'
                          : widget.data.name,
                      color: CustomColor.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
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
                rating: widget.data.rating * 1.0,
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
                  fontSize: 16),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              CustomText(
                  text: description,
                  color: CustomColor.black[2],
                  context: context,
                  textAlign: TextAlign.justify,
                  maxLines: 7,
                  fontSize: 14),
              CustomSizedBox(
                context: context,
                height: 40,
              ),
              _buildOptionBox(
                  value: 'amountSmallBox',
                  context: context,
                  size: '0.5m x 1m x 2m',
                  deviceSize: deviceSize,
                  price: '${widget.data.priceFrom} VND',
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
                  price: '${widget.data.priceFrom} VND',
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
                      fontSize: 16),
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
                    text: 'Price: ',
                    color: CustomColor.black,
                    context: context,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomSizedBox(
                    context: context,
                    width: 8,
                  ),
                  CustomText(
                      text: '${presenter.model.totalPrice} VND',
                      color: CustomColor.purple,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ],
              ),
              CustomSizedBox(
                context: context,
                height: 32,
              ),
              Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: CustomColor.lightBlue),
                  child: TextButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => BillProtectingService(
                        //               data: data,
                        //             )));
                      },
                      child: Image.asset('assets/images/paypal.png'))),
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
