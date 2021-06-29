import 'dart:math';

import '/common/custom_color.dart';
import '/common/custom_dialog.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import '/models/entity/user.dart';
import '/pages/change_password/change_password_screen.dart';
import '/pages/log_in/log_in_screen.dart';
import '/pages/update_info/update_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
          return CustomDialog(
            content: 'Are you sure?',
            title: 'Log out',
            listAction: [
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
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: CustomText(
                    text: 'Cancel',
                    color: CustomColor.black,
                    context: context,
                    fontSize: 16,
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    imageCache.clear();
    var nowParam = DateFormat('yyyyddMMHHmm').format(DateTime.now());

    final deviceSize = MediaQuery.of(context).size;
    return Consumer<User>(
        builder: (context, value, child) => Container(
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
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(deviceSize.width / 8),
                    //   child: Container(
                    //     width: deviceSize.width / 4,
                    //     height: deviceSize.width / 4,
                    // child: Image(
                    //   image: NetworkImage(value.avatar + '#' + nowParam),
                    //   fit: BoxFit.cover,
                    //   key: ValueKey(new Random().nextInt(100)),
                    // ),
                    //   ),
                    // ),
                    Container(
                      width: deviceSize.width / 4,
                      height: deviceSize.width / 4,
                      child: Stack(children: [
                        ClipRRect(
                            borderRadius:
                                BorderRadius.circular(deviceSize.width / 8),
                            child: Container(
                              width: deviceSize.width / 4,
                              height: deviceSize.width / 4,
                              child: Image(
                                image:
                                    NetworkImage(value.avatar + '#' + nowParam),
                                fit: BoxFit.cover,
                                key: ValueKey(new Random().nextInt(100)),
                              ),
                            )),
                        Positioned(
                          bottom: 0,
                          right: 2,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      (UpdateInfoScreen()),
                                ),
                              );
                            },
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
                                  child: Image.asset('assets/images/edit.png')),
                            ),
                          ),
                        )
                      ]),
                    ),
                    CustomSizedBox(
                      context: context,
                      height: 16,
                    ),
                    CustomText(
                      text: value.name,
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
            ));
  }
}
