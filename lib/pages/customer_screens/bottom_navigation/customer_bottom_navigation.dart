import 'package:app_warehouse/common/custom_app_bar.dart';
import 'package:app_warehouse/pages/customer_screens/history_booking/history_booking_screen.dart';
import 'package:app_warehouse/pages/customer_screens/home/home_screen.dart';
import 'package:app_warehouse/pages/customer_screens/profile/profile_screen.dart';
import 'package:app_warehouse/pages/owner_screens/home_screen/owner_home_screen.dart';
import 'package:app_warehouse/common/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';

class CustomerBottomNavigation extends StatefulWidget {
  @override
  _CustomerBottomNavigationState createState() =>
      _CustomerBottomNavigationState();
}

class _CustomerBottomNavigationState extends State<CustomerBottomNavigation> {
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
      // resizeToAvoidBottomPadding: false,
      body: Stack(
        children: [
          IndexedStack(
            index: _index,
            children: [
              CustomerHomeScreen(),
              HistoryBookingScreen(),
              ProfileScreen()
            ],
          ),
          CustomBottomNavigation(
            deviceSize: deviceSize,
            index: _index,
            tapTab: _tapTab,
          )
        ],
      ),
    );
  }
}
