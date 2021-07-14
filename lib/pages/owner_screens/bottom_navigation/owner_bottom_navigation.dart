import '/common/custom_color.dart';
import '/common/custom_owner_bottm_navigation.dart';
import '/pages/owner_screens/bill/bill_screen.dart';
import '/pages/owner_screens/create_storage/create_storage_screen.dart';
import '/pages/owner_screens/home_screen/owner_home_screen.dart';
import '/pages/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class OwnerBottomNavigation extends StatefulWidget {
  @override
  _OwnerBottomNavigationState createState() => _OwnerBottomNavigationState();
}

class _OwnerBottomNavigationState extends State<OwnerBottomNavigation> {
  int _index = 0;
  bool isForceReload = false;
  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  void _tapTab(int index, bool isForceReload) {
    setState(() {
      _index = index;
      if (_index == 0 && isForceReload == true) {
        this.isForceReload = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: CustomColor.white,
      body: Stack(
        children: [
          IndexedStack(
            index: _index,
            children: [
              OwnerHomeScreen(
                isForceReload: isForceReload,
              ),
              BillScreen(),
              CreateStorageScreen(
                data: null,
                setTab: _tapTab,
              ),
              ProfileScreen()
            ],
          ),
          CustomOwnerBottomNavigation(
            deviceSize: deviceSize,
            index: _index,
            tapTab: _tapTab,
          )
        ],
      ),
    );
  }
}
