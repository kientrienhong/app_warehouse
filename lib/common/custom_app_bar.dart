import 'package:appwarehouse/api/api_services.dart';
import 'package:appwarehouse/common/custom_color.dart';
import 'package:appwarehouse/common/custom_sizebox.dart';
import 'package:appwarehouse/common/custom_text.dart';
import 'package:appwarehouse/models/entity/order.dart';
import 'package:appwarehouse/models/entity/storage.dart';
import 'package:appwarehouse/pages/owner_screens/choose_storage/choose_storage_screen.dart';

import '/common/avatar_widget.dart';
import '/models/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isHome;
  final String name;
  CustomAppBar({this.isHome, this.name});
  void callDetailOrder(BuildContext context, int orderId) async {
    try {
      User user = Provider.of<User>(context, listen: false);

      var resultOrder = await ApiServices.getOrder(user.jwtToken, orderId);
      Order order = Provider.of<Order>(context, listen: false);
      order.setOrder(Order.fromMap(resultOrder.data));
      var resultStorage =
          await ApiServices.getStorage(user.jwtToken, order.idStorage);
      Storage storage = Provider.of<Storage>(context, listen: false);
      storage.setStorage(Storage.fromMap(resultStorage.data));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ChooseStorageScreen(
                    isImported: true,
                    idPreviousStorage: storage.id,
                    order: order,
                  )));
    } catch (e) {
      final snackBar = SnackBar(
        content: Text('Not found!'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

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
            mainAxisAlignment: name == null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
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
              if (name != null)
                Row(children: [
                  CustomSizedBox(
                    context: context,
                    width: 80,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32, bottom: 8),
                      child: CustomText(
                          text: name,
                          color: CustomColor.black,
                          context: context,
                          fontSize: 24),
                    ),
                  ),
                ]),
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
                          callDetailOrder(context, int.parse(barcodeScanRes));
                        } else {
                          final snackBar = SnackBar(
                            content: Text('Not found!'),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
