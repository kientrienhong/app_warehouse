import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:app_warehouse/pages/customer_screens/change_password/change_password_screen.dart';
import 'package:app_warehouse/pages/customer_screens/update_info/update_info_screen.dart';
import 'package:app_warehouse/pages/log_in/log_in_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  Widget _buildMenu(
      {@required String name,
      @required String image,
      @required BuildContext context,
      @required Size deviceSize}) {
    return Container(
      height: deviceSize.height / 8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(image),
          CustomSizedBox(
            context: context,
            height: 12,
          ),
          Container(
            width: deviceSize.width / 5,
            child: CustomText(
              text: name,
              textAlign: TextAlign.center,
              context: context,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              maxLines: 2,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: CustomText(
              text: 'Log out',
              color: Colors.black,
              context: context,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => (LogInScreen()),
                      ),
                      (route) => false,
                    );
                  },
                  child: CustomText(
                    text: 'Log out',
                    color: Colors.red,
                    context: context,
                    fontSize: 12,
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: CustomText(
                    text: 'Cancel',
                    color: CustomColor.black,
                    context: context,
                    fontSize: 12,
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      width: deviceSize.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomSizedBox(
              context: context,
              height: 48,
            ),
            Container(
              width: deviceSize.width / 4,
              height: deviceSize.width / 4,
              child: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(deviceSize.width / 8),
                  child: Container(
                      width: deviceSize.width / 4,
                      height: deviceSize.width / 4,
                      child: Image.asset('assets/images/avatar.png')),
                ),
                Positioned(
                  bottom: 0,
                  right: 2,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        color: CustomColor.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 14,
                              offset: Offset(0, 6),
                              color: Colors.black.withOpacity(0.06))
                        ],
                        borderRadius: BorderRadius.circular(16)),
                    child: Center(
                        child: Image.asset('assets/images/imageIcon.png')),
                  ),
                )
              ]),
            ),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            CustomText(
              text: 'Clarren Jessica',
              color: Colors.black,
              context: context,
              fontSize: 24,
            ),
            CustomSizedBox(
              context: context,
              height: 64,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => (UpdateInfoScreen()),
                      ),
                    );
                  },
                  child: _buildMenu(
                      context: context,
                      deviceSize: deviceSize,
                      image: 'assets/images/document.png',
                      name: 'Change infomation'),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            (ChangePasswordScreen()),
                      ),
                    );
                  },
                  child: _buildMenu(
                      context: context,
                      image: 'assets/images/lockback.png',
                      deviceSize: deviceSize,
                      name: 'Change password'),
                ),
              ],
            ),
            CustomSizedBox(
              context: context,
              height: 48,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _showDialog(context),
                  child: _buildMenu(
                      context: context,
                      image: 'assets/images/logout.png',
                      deviceSize: deviceSize,
                      name: 'Log out'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
