import 'package:app_warehouse/common/custom_app_bar.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/pages/owner_screens/home_screen/owner_storage.dart';
import 'package:flutter/material.dart';

enum StatusCheckingStorage { Pending, Approved, Reject }

class OwnerHomeScreen extends StatelessWidget {
  List<Map<String, dynamic>> mockUpData = [
    {
      'imagePath': 'assets/images/storage1.png',
      'name': 'Medium Storage',
      'address':
          '12, Phan Văn Trị, Phường 6, Quận Gò Vấp, Thành Phố Hồ Chí Minh',
      'rating': 4,
      'statusChecking': StatusCheckingStorage.Approved
    },
    {
      'imagePath': 'assets/images/storage2.png',
      'name': 'Prenimum Storage',
      'address':
          '12, Phan Văn Trị, Phường 6, Quận Gò Vấp, Thành Phố Hồ Chí Minh',
      'rating': 4,
      'statusChecking': StatusCheckingStorage.Pending
    },
    {
      'imagePath': 'assets/images/storage3.png',
      'name': 'Small Storage',
      'address':
          '12, Phan Văn Trị, Phường 6, Quận Gò Vấp, Thành Phố Hồ Chí Minh',
      'rating': 4,
      'statusChecking': StatusCheckingStorage.Reject
    },
    {
      'imagePath': 'assets/images/storage4.png',
      'name': 'Large Storage',
      'address':
          '12, Phan Văn Trị, Phường 6, Quận Gò Vấp, Thành Phố Hồ Chí Minh',
      'rating': 4,
      'statusChecking': StatusCheckingStorage.Pending
    },
  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        children: [
          CustomAppBar(
            isHome: true,
          ),
          CustomSizedBox(
            context: context,
            height: 24,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (_, index) {
              return OwnerStorage(
                  data: mockUpData[index], deviceSize: deviceSize);
            },
            itemCount: mockUpData.length,
          ),
          CustomSizedBox(
            context: context,
            height: 72,
          ),
        ],
      ),
    );
  }
}
