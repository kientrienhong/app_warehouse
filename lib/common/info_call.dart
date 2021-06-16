import 'package:app_warehouse/common/avatar_widget.dart';
import 'package:app_warehouse/common/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoCall extends StatelessWidget {
  final Size deviceSize;
  final String phone;
  final String avatar;
  final String name;

  InfoCall(
      {@required this.deviceSize,
      @required this.phone,
      @required this.avatar,
      @required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceSize.height / 8,
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
              name: name,
              imageUrl: avatar,
              role: 'Customer'),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: deviceSize.height / 16,
              width: deviceSize.height / 16,
              color: CustomColor.green,
              child: TextButton(
                  onPressed: () {
                    launch('tel: $phone');
                  },
                  child: Image.asset('assets/images/call.png')),
            ),
          ),
        ],
      ),
    );
  }
}
