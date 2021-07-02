import 'package:appwarehouse/common/custom_button.dart';
import 'package:appwarehouse/common/custom_color.dart';
import 'package:appwarehouse/common/custom_input.dart';
import 'package:appwarehouse/common/custom_sizebox.dart';
import 'package:appwarehouse/common/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailBill extends StatefulWidget {
  @override
  _DetailBillState createState() => _DetailBillState();
}

class _DetailBillState extends State<DetailBill> {
  TextEditingController _controller;
  FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColor.white,
      body: Padding(
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
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  CustomSizedBox(
                    context: context,
                    height: 8,
                  ),
                  CustomOutLineInput(
                      isDisable: false,
                      focusNode: _focusNode,
                      controller: _controller,
                      deviceSize: deviceSize,
                      labelText: 'Comment'),
                  CustomButton(
                      height: 32,
                      text: 'Comment',
                      width: double.infinity,
                      isLoading: false,
                      textColor: CustomColor.green,
                      onPressFunction: () {},
                      buttonColor: CustomColor.lightBlue,
                      borderRadius: 4)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
