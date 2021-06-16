import 'package:app_warehouse/models/entity/user.dart';
import 'package:app_warehouse/pages/customer_screens/history_booking/history_booking_screen.dart';
import 'package:app_warehouse/pages/customer_screens/home/home_screen.dart';
import 'package:app_warehouse/pages/customer_screens/profile/profile_screen.dart';
import 'package:app_warehouse/common/custom_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerBottomNavigation extends StatefulWidget {
  final User user;

  CustomerBottomNavigation({this.user});

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
