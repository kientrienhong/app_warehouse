import 'package:appwarehouse/common/custom_app_bar.dart';
import 'package:appwarehouse/common/custom_color.dart';
import 'package:appwarehouse/common/custom_sizebox.dart';
import 'package:appwarehouse/common/custom_text.dart';
import 'package:appwarehouse/models/entity/box.dart';
import 'package:appwarehouse/models/entity/shelf.dart';
import 'package:appwarehouse/models/entity/storage.dart';
import 'package:appwarehouse/models/entity/user.dart';
import 'package:appwarehouse/pages/owner_screens/detail_storage/status_shelf.dart';
import 'package:appwarehouse/presenters/choose_storage_presenter.dart';
import 'package:appwarehouse/views/choose_storage_view.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

class ChooseStorageScreen extends StatefulWidget {
  final int idPreviousStorage;
  final Box box;
  ChooseStorageScreen({this.idPreviousStorage, this.box});
  @override
  _ChooseStorageScreenState createState() => _ChooseStorageScreenState();
}

class _ChooseStorageScreenState extends State<ChooseStorageScreen>
    implements ChooseStorageView {
  ChooseStoragePresenter presenter;

  Widget _buildStorage(
      {Size deviceSize, Storage data, BuildContext context, int currentIndex}) {
    Color textColor = currentIndex == presenter.model.index
        ? CustomColor.purple
        : CustomColor.black[3];
    return Container(
      height: deviceSize.height / 4,
      width: deviceSize.width / 3,
      margin:
          EdgeInsets.only(right: 12, top: 8, left: currentIndex == 0 ? 0 : 12),
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
                          child: Image.network(
                            data.picture[0]['imageUrl'],
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
  void updateViewCurrentStorage(Storage storage) {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Storage storage = Provider.of<Storage>(context, listen: false);
    presenter = ChooseStoragePresenter(storage.id);
    presenter.view = this;
    presenter.model.currentStorageId = widget.idPreviousStorage;
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
    await presenter.loadListStorage(
        pageKey, 5, user.jwtToken, '', widget.idPreviousStorage);
  }

  @override
  void fetchShelf(int pageKey, int idStorage) async {
    User user = Provider.of<User>(context, listen: false);
    await presenter.loadListShelves(pageKey, 5, user.jwtToken,
        presenter.model.currentStorageId, widget.box.shelfId);
  }

  @override
  void onClickStorage(int index) {
    setState(() {
      presenter.model.index = index + 1;
      presenter.model.currentStorageId =
          presenter.model.pagingStorageController.itemList[index].id;
    });
    presenter.model.pagingShelfController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 24),
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
              width: double.infinity,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                CustomText(
                    text: 'Box\'s current position',
                    color: CustomColor.blue,
                    context: context,
                    fontSize: 14),
              ]),
            ),
            CustomSizedBox(
              context: context,
              height: 4,
            ),
            Container(
              height: deviceSize.height / 7,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                _buildStorage(
                    context: context,
                    currentIndex: 0,
                    data: Provider.of<Storage>(context, listen: false),
                    deviceSize: deviceSize),
                Container(
                  width: 4,
                  height: deviceSize.height / 7,
                  color: CustomColor.black[2],
                ),
                Container(
                  width: deviceSize.width * (2 / 3) - 40,
                  child: RefreshIndicator(
                    onRefresh: () => Future.sync(() =>
                        presenter.model.pagingStorageController.refresh()),
                    child: PagedListView<int, Storage>(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      pagingController: presenter.model.pagingStorageController,
                      builderDelegate: PagedChildBuilderDelegate<Storage>(
                          itemBuilder: (context, item, index) =>
                              GestureDetector(
                                onTap: () => onClickStorage(index),
                                child: _buildStorage(
                                    context: context,
                                    currentIndex: index + 1,
                                    data: item,
                                    deviceSize: deviceSize),
                              )),
                    ),
                  ),
                ),
              ]),
            ),
            CustomSizedBox(
              context: context,
              height: 8,
            ),
            CustomText(
                text: 'Shelves',
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 24),
            CustomSizedBox(
              context: context,
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: CustomColor.lightBlue,
                      width: 2)),
              width: double.infinity,
              margin: const EdgeInsets.only(right: 24),
              child: Column(children: [
                CustomText(
                  color: CustomColor.purple,
                  context: context,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  text: 'Box\'s current shelf position',
                ),
                CustomSizedBox(
                  context: context,
                  height: 8,
                ),
                StatusShelf(
                  deviceSize: deviceSize,
                  data: Provider.of<Shelf>(context, listen: false),
                  isMove: true,
                ),
              ]),
            ),
            CustomSizedBox(
              context: context,
              height: 8,
            ),
            Container(
              height: deviceSize.height / 4,
              child: RefreshIndicator(
                onRefresh: () => Future.sync(
                    () => presenter.model.pagingShelfController.refresh()),
                child: PagedListView<int, Shelf>(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  pagingController: presenter.model.pagingShelfController,
                  builderDelegate: PagedChildBuilderDelegate<Shelf>(
                    itemBuilder: (context, item, index) => StatusShelf(
                      deviceSize: deviceSize,
                      data: item,
                      isMove: true,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
