import 'package:app_warehouse/common/avatar_widget.dart';
import 'package:app_warehouse/common/custom_app_bar.dart';
import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:app_warehouse/pages/customer_screens/for_rent_detail/bill_for_rent.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

class DetailForRentScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  DetailForRentScreen({this.data});

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
                  child: Image.asset('assets/images/storage1.png',
                      fit: BoxFit.cover),
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
                      text: data['name'],
                      color: CustomColor.black,
                      context: context,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  CustomText(
                      text: data['size'],
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
                text: data['address'],
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
                rating: data['rating'] * 1.0,
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
                height: 16,
              ),
              Container(
                height: deviceSize.height / 8.5,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: CustomColor.purple)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AvatarWidget(
                        deviceSize: deviceSize,
                        isHome: false,
                        name: 'Clarren Jessica',
                        imageUrl: 'assets/images/avatar.png',
                        role: 'Owner'),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: deviceSize.height / 16,
                        width: deviceSize.height / 16,
                        color: CustomColor.green,
                        child: TextButton(
                            onPressed: () {},
                            child: Image.asset('assets/images/call.png')),
                      ),
                    ),
                  ],
                ),
              ),
              CustomSizedBox(
                context: context,
                height: 8,
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
                      onPressed: () {},
                      child: Image.asset('assets/images/sub.png',
                          fit: BoxFit.cover),
                    ),
                  ),
                  CustomText(
                    text: '1',
                    color: CustomColor.purple,
                    context: context,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    child: TextButton(
                        onPressed: () {},
                        child: Image.asset('assets/images/plus.png',
                            fit: BoxFit.cover)),
                  ),
                ],
              ),
              CustomSizedBox(
                context: context,
                height: 8,
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
                      text: data['price'] + ' VND',
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
              Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: CustomColor.lightBlue),
                  child: TextButton(
                      onPressed: () {
                        print('test00');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BillForRent(
                                      data: data,
                                    )));
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
