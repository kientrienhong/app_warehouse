import 'package:app_warehouse/common/custom_app_bar.dart';
import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/models/entity/user.dart';
import 'package:app_warehouse/pages/customer_screens/for_rent_detail/detail_for_rent_screen.dart';
import 'package:app_warehouse/pages/customer_screens/home/storage_for_rent_widget.dart';
import 'package:app_warehouse/pages/customer_screens/home/storage_procteting_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

enum Service { FOR_RENT, PROTECTING_SERVICE }

class CustomerHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    User user = Provider.of<User>(context, listen: false);
    List<Map<String, dynamic>> mockUpData = [
      {
        'imagePath': 'assets/images/storage1.png',
        'name': 'Medium Storage',
        'address':
            '12, Phan Văn Trị, Phường 6, Quận Gò Vấp, Thành Phố Hồ Chí Minh',
        'rating': 4,
        'service': Service.PROTECTING_SERVICE
      },
      {
        'imagePath': 'assets/images/storage2.png',
        'name': 'Prenimum Storage',
        'address':
            '12, Phan Văn Trị, Phường 6, Quận Gò Vấp, Thành Phố Hồ Chí Minh',
        'rating': 4,
        'service': Service.PROTECTING_SERVICE
      },
      {
        'imagePath': 'assets/images/storage3.png',
        'name': 'Small Storage',
        'address':
            '12, Phan Văn Trị, Phường 6, Quận Gò Vấp, Thành Phố Hồ Chí Minh',
        'rating': 4,
        'service': Service.PROTECTING_SERVICE
      },
      {
        'imagePath': 'assets/images/storage4.png',
        'name': 'Large Storage',
        'address':
            '12, Phan Văn Trị, Phường 6, Quận Gò Vấp, Thành Phố Hồ Chí Minh',
        'rating': 4,
        'service': Service.PROTECTING_SERVICE
      },
    ];

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
          Row(
            children: [
              Container(
                width: deviceSize.width - 48,
                height: 40,
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: ImageIcon(
                        AssetImage('assets/images/search.png'),
                        color: CustomColor.black,
                      ),
                      suffixIcon: ImageIcon(
                        AssetImage('assets/images/filter.png'),
                        color: CustomColor.black,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: CustomColor.black[2]))),
                ),
              )
            ],
          ),
          CustomSizedBox(
            context: context,
            height: 24,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (_, index) {
              if (mockUpData[index]['service'] == Service.FOR_RENT)
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailForRentScreen(
                                data: mockUpData[index],
                              )),
                    );
                  },
                  child: StorageForRentWidget(
                      data: mockUpData[index], deviceSize: deviceSize),
                );

              return StorageProtectingWidget(
                  data: mockUpData[index], deviceSize: deviceSize);
            },
            itemCount: mockUpData.length,
          ),
          CustomSizedBox(
            context: context,
            height: 72,
          )
        ],
      ),
    );
  }
}
