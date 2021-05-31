import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:app_warehouse/pages/owner_screens/shelf_detail/shelf_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StatusShelf extends StatelessWidget {
  final Size deviceSize;
  final Map<String, dynamic> data;
  StatusShelf({@required this.deviceSize, @required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ShelfDetailScreen(
                      data: data,
                    )));
      },
      child: Container(
        height: deviceSize.height / 18,
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: deviceSize.height / 18,
              width: deviceSize.width / 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: CustomColor.lightBlue),
              child: Center(
                child: CustomText(
                  text: data['name'],
                  color: CustomColor.black,
                  context: context,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CustomSizedBox(
              context: context,
              width: 24,
            ),
            CustomText(
                text: 'Used',
                color: CustomColor.black[2],
                context: context,
                fontSize: 12),
            CustomSizedBox(
              context: context,
              width: 4,
            ),
            new LinearPercentIndicator(
              width: deviceSize.width / 2.4,
              lineHeight: 8,
              backgroundColor: CustomColor.lightBlue,
              percent: data['percent'] / 100,
              progressColor: CustomColor.purple,
            ),
            CustomSizedBox(
              context: context,
              width: 2,
            ),
            CustomText(
                text: data['percent'].toString() + '%',
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16)
          ],
        ),
      ),
    );
  }
}
