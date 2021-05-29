import 'package:app_warehouse/common/bill_widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HistoryBookingScreen extends StatelessWidget {
  List<Map<String, dynamic>> mockUpData = [
    {
      'imagePath': 'assets/images/storage1.png',
      'name': 'Medium Storage',
      'address':
          '12, Phan Văn Trị, Phường 6, Quận Gò Vấp, Thành Phố Hồ Chí Minh',
      'rating': 4,
    },
    {
      'imagePath': 'assets/images/storage2.png',
      'name': 'Prenimum Storage',
      'address':
          '12, Phan Văn Trị, Phường 6, Quận Gò Vấp, Thành Phố Hồ Chí Minh',
      'rating': 4,
    },
    {
      'imagePath': 'assets/images/storage3.png',
      'name': 'Small Storage',
      'address':
          '12, Phan Văn Trị, Phường 6, Quận Gò Vấp, Thành Phố Hồ Chí Minh',
      'rating': 4,
    },
    {
      'imagePath': 'assets/images/storage4.png',
      'name': 'Large Storage',
      'address':
          '12, Phan Văn Trị, Phường 6, Quận Gò Vấp, Thành Phố Hồ Chí Minh',
      'rating': 4,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(left: 24, right: 24),
          child: SingleChildScrollView(
            child: Container(
              height: deviceSize.height * 1.25,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: deviceSize.height,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  // autoPlay: false,
                ),
                items: mockUpData.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: BillWidget(
                          data: i,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          )),
    );
  }
}
