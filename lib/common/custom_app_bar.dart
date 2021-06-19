import 'package:app_warehouse/common/avatar_widget.dart';
import 'package:app_warehouse/models/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHome;
  CustomAppBar({this.isHome});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size;
    String role = user.role == UserRole.customer ? 'Customer' : 'Owner';
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
                      name: user.name,
                      imageUrl: 'assets/images/avatar.png',
                      role: role)
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
