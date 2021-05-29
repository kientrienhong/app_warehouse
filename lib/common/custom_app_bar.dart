import 'package:app_warehouse/common/avatar_widget.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHome;
  CustomAppBar({this.isHome});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size(double.infinity, 80),
      child: Container(
        color: Colors.transparent,
        width: deviceSize.width,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 8),
              child: isHome
                  ? AvatarWidget(
                      deviceSize: deviceSize,
                      isHome: isHome,
                      name: 'Clarren Jessica',
                      imageUrl: 'assets/images/avatar.png',
                      role: 'Customer')
                  : GestureDetector(
                      onTap: () => {Navigator.of(context).pop()},
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Image.asset('assets/images/arrowLeft.png'),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
