import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_owner_bottm_navigation.dart';
import 'package:app_warehouse/pages/owner_screens/bill/bill_screen.dart';
import 'package:app_warehouse/pages/owner_screens/create_storage/create_storage_screen.dart';
import 'package:app_warehouse/pages/owner_screens/home_screen/owner_home_screen.dart';
import 'package:app_warehouse/pages/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class OwnerBottomNavigation extends StatefulWidget {
  @override
  _OwnerBottomNavigationState createState() => _OwnerBottomNavigationState();
}

class _OwnerBottomNavigationState extends State<OwnerBottomNavigation> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  void _tapTab(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      // drawerScrimColor: Color.fromARGB(51, 51, 51, 5),
      resizeToAvoidBottomInset: true,
      backgroundColor: CustomColor.white,
      // resizeToAvoidBottomPadding: false,
      body: Stack(
        children: [
          IndexedStack(
            index: _index,
            children: [
              OwnerHomeScreen(),
              BillScreen(),
              CreateStorageScreen(
                data: null,
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
