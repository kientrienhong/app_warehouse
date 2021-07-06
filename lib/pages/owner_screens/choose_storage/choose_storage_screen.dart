import 'package:appwarehouse/common/custom_app_bar.dart';
import 'package:appwarehouse/common/custom_color.dart';
import 'package:appwarehouse/common/custom_sizebox.dart';
import 'package:appwarehouse/common/custom_text.dart';
import 'package:appwarehouse/models/entity/box.dart';
import 'package:appwarehouse/models/entity/storage.dart';
import 'package:appwarehouse/models/entity/user.dart';
import 'package:appwarehouse/presenters/choose_storage_presenter.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class ChooseStorageScreen extends StatefulWidget {
  final int idCurrentStorage;
  final Box box;
  ChooseStorageScreen({this.idCurrentStorage, this.box});
  @override
  _ChooseStorageScreenState createState() => _ChooseStorageScreenState();
}

class _ChooseStorageScreenState extends State<ChooseStorageScreen> {
  ChooseStoragePresenter presenter;

  Widget _buildStorage(
      {Size deviceSize, Storage data, BuildContext context, int currentIndex}) {
    Color textColor = currentIndex == presenter.model.index
        ? CustomColor.purple
        : CustomColor.black[3];
    return Container(
      height: deviceSize.height / 4,
      width: deviceSize.width / 3,
      margin: const EdgeInsets.only(right: 24),
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                          width: deviceSize.width / 3,
                          height: deviceSize.height / 12,
                          child: Image.asset(
                            data.picture[0],
                            fit: BoxFit.cover,
                          )),
                    ),
                    CustomSizedBox(
                      context: context,
                      height: 8,
                    ),
                    CustomText(
                        text: data.name,
                        color: textColor,
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)
                  ])),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    presenter = ChooseStoragePresenter();
    presenter.view = this;
    User user = Provider.of<User>(context, listen: false);
    presenter.getCurrentStorage(widget.idCurrentStorage, user.jwtToken);
    presenter.model.pagingStorageController.addPageRequestListener((pageKey) {
      fetchStorage(pageKey);
    });
    presenter.model.pagingShelfController.addPageRequestListener((pageKey) {
      fetchShelf(pageKey, presenter.model.currentStorageId);
    });
  }

  @override
  void fetchStorage(int pageKey) async {
    User user = Provider.of<User>(context, listen: false);
    await presenter.loadListStorage(pageKey, 5, user.jwtToken, '');
  }

  @override
  void fetchShelf(int pageKey, int idStorage) async {
    User user = Provider.of<User>(context, listen: false);
    await presenter.loadListShelves(
        pageKey, 5, user.jwtToken, presenter.model.currentStorageId);
  }

  @override
  void onClickStorage(int index) {
    setState(() {
      presenter.model.index = index;
      presenter.model.currentStorageId =
          presenter.model.pagingStorageController.itemList[index];
    });
    presenter.model.pagingShelfController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            CustomAppBar(
              isHome: false,
            ),
            CustomText(
                text: 'Storages',
                color: CustomColor.black,
                context: context,
                fontSize: 24),
            CustomSizedBox(
              context: context,
              height: 8,
            ),
            Container(
              height: deviceSize.height / 1.5,
              child: RefreshIndicator(
                onRefresh: () => Future.sync(
                    () => presenter.model.pagingStorageController.refresh()),
                child: PagedListView<int, Storage>(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  pagingController: presenter.model.pagingStorageController,
                  builderDelegate: PagedChildBuilderDelegate<Storage>(
                      itemBuilder: (context, item, index) => _buildStorage(
                          context: context,
                          currentIndex: index,
                          data: item,
                          deviceSize: deviceSize)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
