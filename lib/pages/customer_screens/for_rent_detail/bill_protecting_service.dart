import 'package:appwarehouse/models/entity/order.dart';

import '/common/bill_widget.dart';
import '/common/custom_app_bar.dart';
import '/common/custom_color.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text_button.dart';
import '/pages/customer_screens/bottom_navigation/customer_bottom_navigation.dart';
import 'package:flutter/material.dart';

class BillProtectingService extends StatelessWidget {
  final Order data;

  BillProtectingService({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              CustomAppBar(
                isHome: false,
              ),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              BillWidget(
                data: data,
              ),
              CustomSizedBox(
                context: context,
                height: 24,
              ),
              Container(
                height: 38,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: CustomColor.lightBlue),
                child: CustomTextButton(
                    text: 'Done',
                    textColor: CustomColor.green,
                    context: context,
                    onPressFunction: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              (CustomerBottomNavigation()),
                        ),
                        (route) => false,
                      );
                    },
                    fontSize: 16),
              ),
              CustomSizedBox(
                context: context,
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
