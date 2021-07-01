import 'package:appwarehouse/models/entity/storage.dart';
import 'package:appwarehouse/models/entity/user.dart';
import 'package:appwarehouse/pages/owner_screens/detail_storage/status_shelf.dart';
import 'package:appwarehouse/presenters/owner_detail_storage_presenter.dart';
import 'package:appwarehouse/views/owner_detail_storage_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '/common/custom_app_bar.dart';
import '/common/custom_button.dart';
import '/common/custom_color.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OwnerDetailStorage extends StatefulWidget {
  final Storage data;

  OwnerDetailStorage({this.data});

  @override
  _OwnerDetailStorageState createState() => _OwnerDetailStorageState();
}

class _OwnerDetailStorageState extends State<OwnerDetailStorage>
    implements OwnerDetailStorageView {
  OwnerDetailStoragePresenter presenter;
  @override
  void initState() {
    super.initState();
    presenter = OwnerDetailStoragePresenter();
    presenter.view = this;
    presenter.model.pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }

  @override
  fetchPage(int pageKey) {
    User user = Provider.of<User>(context, listen: false);
    presenter.loadListShelves(pageKey, 10, user.jwtToken, widget.data.id);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            CustomAppBar(
              isHome: false,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              CustomText(
                color: CustomColor.black,
                context: context,
                fontSize: 24,
                text: 'Shelves',
                fontWeight: FontWeight.bold,
              ),
              Container(
                child: ImageIcon(
                  AssetImage('assets/images/plus.png'),
                  color: CustomColor.purple,
                ),
              )
            ]),
            CustomSizedBox(
              context: context,
              height: 8,
            ),
            PagedListView<int, dynamic>(
              shrinkWrap: true,
              pagingController: presenter.model.pagingController,
              builderDelegate: PagedChildBuilderDelegate<dynamic>(
                  itemBuilder: (context, item, index) =>
                      StatusShelf(data: item, deviceSize: deviceSize)),
            ),
            CustomSizedBox(
              context: context,
              height: 24,
            ),
            CustomButton(
                height: 32,
                text: 'Submit',
                width: double.infinity,
                textColor: CustomColor.green,
                onPressFunction: () {},
                buttonColor: CustomColor.lightBlue,
                borderRadius: 4),
            CustomSizedBox(
              context: context,
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
