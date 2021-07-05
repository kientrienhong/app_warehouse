import '/models/entity/storage.dart';
import '/models/entity/user.dart';
import '/pages/owner_screens/detail_storage/status_shelf.dart';
import '/presenters/owner_detail_storage_presenter.dart';
import '/views/owner_detail_storage_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '/common/custom_app_bar.dart';
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
  void onHandleAddShelf(int idStorage) {
    User user = Provider.of<User>(context, listen: false);
  }

  @override
  void onHandleDeleteShelf(int idShelf) async {
    User user = Provider.of<User>(context, listen: false);
    var result = await presenter.deleteShelf(user.jwtToken, idShelf);
    if (result == true) {
      Navigator.of(context).pop();
      presenter.model.pagingController.refresh();
    }
  }

  @override
  void updateLoadingAddShelf() {
    setState(() {
      presenter.model.isLoadingAddShelf = !presenter.model.isLoadingAddShelf;
    });
  }

  @override
  void updateLoadingDeleteShelf() {
    setState(() {
      presenter.model.isLoadingDeleteShelf =
          !presenter.model.isLoadingDeleteShelf;
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
                  itemBuilder: (context, item, index) => StatusShelf(
                        data: item,
                        deviceSize: deviceSize,
                        presenter: presenter,
                      )),
            ),
            CustomSizedBox(
              context: context,
              height: 24,
            ),
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
