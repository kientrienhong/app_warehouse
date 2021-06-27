import '/models/entity/user.dart';
import '/pages/customer_screens/history_booking/history_booking_screen.dart';
import '/pages/customer_screens/home/home_screen.dart';
import '/common/custom_bottom_navigation.dart';
import '/pages/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class CustomerBottomNavigation extends StatefulWidget {
  CustomerBottomNavigation();

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
      resizeToAvoidBottomInset: true,
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
