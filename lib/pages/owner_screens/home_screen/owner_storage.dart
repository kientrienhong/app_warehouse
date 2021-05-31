import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:app_warehouse/pages/owner_screens/create_storage/create_storage_screen.dart';
import 'package:app_warehouse/pages/owner_screens/detail_storage/owner_detail_storage.dart';
import 'package:app_warehouse/pages/owner_screens/home_screen/owner_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OwnerStorage extends StatelessWidget {
  final Map<String, dynamic> data;
  final Size deviceSize;

  OwnerStorage({@required this.data, @required this.deviceSize});

  Color colorStatusChecking;
  String statusChecking;
  @override
  Widget build(BuildContext context) {
    switch (data['statusChecking']) {
      case StatusCheckingStorage.Approved:
        {
          colorStatusChecking = CustomColor.green;
          statusChecking = 'Approved';
          break;
        }
      case StatusCheckingStorage.Pending:
        {
          colorStatusChecking = CustomColor.orange;
          statusChecking = 'Pending';
          break;
        }
      default:
        {
          colorStatusChecking = CustomColor.red;
          statusChecking = 'Reject';
          break;
        }
    }

    return GestureDetector(
      onTap: () {
        if (data['statusChecking'] == StatusCheckingStorage.Approved) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => OwnerDetailStorage()));
        }
      },
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.only(bottom: 24),
          height: deviceSize.height / 2.6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: CustomColor.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 14,
                    offset: Offset(0, 6),
                    color: Color(0xFF000000).withOpacity(0.06))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                child: Container(
                    width: deviceSize.width,
                    height: deviceSize.height / 5.2,
                    child: Image.asset(
                      data['imagePath'],
                      fit: BoxFit.cover,
                    )),
              ),
              CustomSizedBox(
                height: 16,
                context: context,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: data['name'],
                      color: CustomColor.black,
                      context: context,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: statusChecking,
                      color: colorStatusChecking,
                      context: context,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 16),
                  child: CustomText(
                      text: data['address'],
                      color: CustomColor.black[2],
                      context: context,
                      maxLines: 2,
                      fontSize: 14)),
              CustomSizedBox(
                context: context,
                height: 12,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Scaffold(
                                        backgroundColor: CustomColor.white,
                                        body: CreateStorageScreen(),
                                      )));
                        },
                        child: Image.asset('assets/images/edit.png'))
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
