import '/common/avatar_widget.dart';
import '/models/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHome;

  CustomAppBar({this.isHome});

  @override
  Widget build(BuildContext context) {
    var nowParam = DateFormat('yyyyddMMHHmm').format(DateTime.now());

    final deviceSize = MediaQuery.of(context).size;
    return Consumer<User>(
      builder: (ctx, value, child) => PreferredSize(
        preferredSize: Size(double.infinity, 80),
        child: Container(
          color: Colors.transparent,
          width: deviceSize.width,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 8),
                child: isHome
                    ? AvatarWidget(
                        deviceSize: deviceSize,
                        isHome: isHome,
                        name: value.name,
                        imageUrl: value.avatar + '#' + nowParam,
                        role: value.role == UserRole.customer
                            ? 'Customer'
                            : 'Owner')
                    : GestureDetector(
                        onTap: () => {Navigator.of(context).pop()},
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Image.asset('assets/images/arrowLeft.png'),
                        ),
                      ),
              ),
              if (value.role == UserRole.owner && isHome == true)
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 8),
                  child: GestureDetector(
                      onTap: () async {
                        String barcodeScanRes =
                            await FlutterBarcodeScanner.scanBarcode(
                                '#8099FF', 'Cancel', false, ScanMode.DEFAULT);
                        if (barcodeScanRes != '-1') {
                          // Navigator to detail storage
                        }
                      },
                      child: Image.asset('assets/images/scan.png')),
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
