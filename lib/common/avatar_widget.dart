import 'dart:math';

import '/common/custom_color.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final Size deviceSize;
  final bool isHome;
  final String name;
  final String imageUrl;
  final String role;

  AvatarWidget(
      {@required this.deviceSize,
      @required this.isHome,
      @required this.name,
      @required this.imageUrl,
      @required this.role});

  @override
  Widget build(BuildContext context) {
    final subTitle = isHome == true ? 'Hi' : role;
    return Container(
      height: 48,
      width: deviceSize.width / 2,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              height: 48,
              width: 48,
              // child: Image.network(
              //   imageUrl,
              //   fit: BoxFit.cover,
              // ),
              child: Image(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
                key: ValueKey(new Random().nextInt(100)),
              ),
            ),
          ),
          CustomSizedBox(
            context: context,
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(
                  text: subTitle,
                  color: CustomColor.black[2],
                  context: context,
                  fontSize: 14),
              CustomSizedBox(
                context: context,
                height: 2,
              ),
              CustomText(
                  text: name,
                  maxLines: 2,
                  color: CustomColor.black,
                  context: context,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ],
          )
        ],
      ),
    );
  }
}
