import '/common/custom_color.dart';
import 'package:flutter/material.dart';

class CustomOwnerBottomNavigation extends StatelessWidget {
  final Size deviceSize;
  final Function tapTab;
  final int index;
  CustomOwnerBottomNavigation({this.deviceSize, this.tapTab, this.index});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(
            bottom: 16,
            left: deviceSize.width / 15,
            right: deviceSize.width / 15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 16,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
              child: BottomNavigationBar(
                selectedItemColor: CustomColor.purple,
                backgroundColor: CustomColor.white,
                type: BottomNavigationBarType.fixed,
                currentIndex: index,
                onTap: (index) => tapTab(index, false),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/images/home.png'),
                      ),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/images/document.png'),
                      ),
                      label: 'Orders'),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/images/paperplus.png'),
                      ),
                      label: 'Add Storage'),
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/images/profile.png'),
                      ),
                      label: 'Profile'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
