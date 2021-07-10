import 'package:appwarehouse/common/custom_app_bar.dart';
import 'package:appwarehouse/common/custom_button.dart';
import 'package:appwarehouse/common/custom_color.dart';
import 'package:appwarehouse/common/custom_input.dart';
import 'package:appwarehouse/common/custom_msg_input.dart';
import 'package:appwarehouse/common/custom_sizebox.dart';
import 'package:appwarehouse/common/custom_text.dart';
import 'package:appwarehouse/models/entity/box.dart';
import 'package:appwarehouse/models/entity/imported_boxes.dart';
import 'package:appwarehouse/models/entity/order.dart';
import 'package:appwarehouse/models/entity/shelf.dart';
import 'package:appwarehouse/models/entity/storage.dart';
import 'package:appwarehouse/models/entity/user.dart';
import 'package:appwarehouse/pages/owner_screens/detail_storage/status_shelf.dart';
import 'package:appwarehouse/presenters/choose_storage_presenter.dart';
import 'package:appwarehouse/views/choose_storage_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class ChooseStorageScreen extends StatefulWidget {
  final int idPreviousStorage;
  final Box box;
  final Order order;
  final bool isImported;
  final bool isMove;
  ChooseStorageScreen(
      {this.isImported: false,
      this.idPreviousStorage,
      this.box,
      this.order,
      this.isMove: false});
  @override
  _ChooseStorageScreenState createState() => _ChooseStorageScreenState();
}

class _ChooseStorageScreenState extends State<ChooseStorageScreen>
    implements ChooseStorageView {
  ChooseStoragePresenter presenter;
  TextEditingController reasonController = TextEditingController();
  FocusNode focusNode = FocusNode();
  Widget _buildNoteForIcon(
      {@required String name,
      @required Color color,
      @required int quantity,
      @required Size deviceSize,
      @required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: deviceSize.width / 11,
          width: deviceSize.width / 11,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: CustomText(
              context: context,
              text: quantity.toString(),
              color: CustomColor.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        CustomSizedBox(
          context: context,
          width: 8,
        ),
        CustomText(
            text: name,
            color: CustomColor.black,
            fontWeight: FontWeight.bold,
            context: context,
            fontSize: 14)
      ],
    );
  }

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
  void updateImportedLoading() {
    setState(() {
      presenter.model.isLoadingImportedBoxes =
          !presenter.model.isLoadingImportedBoxes;
    });
  }

  @override
  void updateMsg(String msg, bool isError) {
    setState(() {
      presenter.model.msgImportedBoxes = msg;
      presenter.model.isErrorImportedBoxes = isError;
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
    await presenter.loadListShelves(
        pageKey,
        5,
        user.jwtToken,
        presenter.model.currentStorageId,
        widget.box == null ? -1 : widget.box.shelfId);
  }

  @override
  void onClickStorage(int index) {
    if (index == 0) {
      Storage storage = Provider.of<Storage>(context, listen: false);

      setState(() {
        presenter.model.index = index;
        presenter.model.currentStorageId = storage.id;
      });
      presenter.model.pagingShelfController.refresh();
      return;
    }
    setState(() {
      presenter.model.index = index;
      presenter.model.currentStorageId =
          presenter.model.pagingStorageController.itemList[index - 1].id;
    });
    presenter.model.pagingShelfController.refresh();
  }

  @override
  void onClickSubmitImportBox() async {
    User user = Provider.of<User>(context, listen: false);
    ImportedBoxes importedBoxes =
        Provider.of<ImportedBoxes>(context, listen: false);
    Order order = Provider.of<Order>(context, listen: false);
    bool result;
    if (importedBoxes.boxInDifferentStorage.keys.length > 0) {
      if (reasonController.text.length == 0) {
        updateMsg('You must provide reason but box another storage', true);
        return;
      }
      result = await presenter.importedBoxes(user.jwtToken,
          importedBoxes.listResult, order, reasonController.text);
    } else {
      result = await presenter.importedBoxes(
          user.jwtToken, importedBoxes.listResult, order, '');
    }

    if (result == true) {
      importedBoxes.setImportedBoxes(ImportedBoxes());
      order.setOrder(Order.empty());
    }
  }

  Widget _buildCustomerOrder(Order order, Size deviceSize) {
    if (widget.isImported == true)
      return Column(
        children: [
          CustomText(
              text: 'Customer\'s order',
              color: CustomColor.purple,
              context: context,
              fontWeight: FontWeight.bold,
              fontSize: 24),
          CustomSizedBox(
            context: context,
            height: 4,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: CustomColor.lightBlue, width: 2),
            ),
            margin: const EdgeInsets.only(right: 24),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            width: double.infinity,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<Order>(
                    builder: (context, item, child) {
                      return _buildNoteForIcon(
                          name: '1m x 1m x 2m',
                          color: CustomColor.lightBlue,
                          quantity: item.bigBoxQuantity,
                          deviceSize: deviceSize,
                          context: context);
                    },
                  ),
                  Consumer<Order>(
                    builder: (context, item, child) {
                      return _buildNoteForIcon(
                          name: '0.5m x 1m x 2m',
                          color: CustomColor.purple,
                          quantity: item.smallBoxQuantity,
                          deviceSize: deviceSize,
                          context: context);
                    },
                  ),
                ],
              ),
              CustomSizedBox(context: context, height: 18),
              Consumer<ImportedBoxes>(
                builder: (context, importedBoxes, child) {
                  if (importedBoxes.boxInDifferentStorage.keys.length > 0)
                    return CustomOutLineInput(
                        isDisable: false,
                        focusNode: focusNode,
                        controller: reasonController,
                        deviceSize: deviceSize,
                        labelText: 'Reason');

                  return Container();
                },
              ),
              if (presenter.model.msgImportedBoxes.length > 0)
                CustomMsgInput(
                    msg: presenter.model.msgImportedBoxes,
                    isError: presenter.model.isErrorImportedBoxes,
                    maxLines: 2),
              CustomSizedBox(context: context, height: 8),
              CustomButton(
                  height: 32,
                  text: 'Submit',
                  width: double.infinity,
                  isLoading: presenter.model.isLoadingImportedBoxes,
                  textColor: CustomColor.green,
                  onPressFunction: () {
                    onClickSubmitImportBox();
                  },
                  buttonColor: CustomColor.lightBlue,
                  borderRadius: 4)
            ]),
          ),
        ],
      );
    return Container();
  }

  @override
  void dispose() {
    super.dispose();
    reasonController.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    Order order = Provider.of<Order>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Column(
            children: [
              CustomAppBar(
                isHome: false,
              ),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              _buildCustomerOrder(order, deviceSize),
              CustomSizedBox(
                context: context,
                height: 8,
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => onClickStorage(0),
                        child: _buildStorage(
                            context: context,
                            currentIndex: 0,
                            data: Provider.of<Storage>(context, listen: false),
                            deviceSize: deviceSize),
                      ),
                      Container(
                        width: 4,
                        height: deviceSize.height / 7,
                        color: CustomColor.black[2],
                      ),
                      presenter.model.pagingStorageController.error == null
                          ? Container(
                              width: deviceSize.width * (2 / 3) - 40,
                              child: RefreshIndicator(
                                onRefresh: () => Future.sync(() => presenter
                                    .model.pagingStorageController
                                    .refresh()),
                                child: PagedListView<int, Storage>(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  pagingController:
                                      presenter.model.pagingStorageController,
                                  builderDelegate:
                                      PagedChildBuilderDelegate<Storage>(
                                          itemBuilder: (context, item, index) =>
                                              GestureDetector(
                                                onTap: () =>
                                                    onClickStorage(index + 1),
                                                child: _buildStorage(
                                                    context: context,
                                                    currentIndex: index + 1,
                                                    data: item,
                                                    deviceSize: deviceSize),
                                              )),
                                ),
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.only(left: 16),
                              child: CustomText(
                                  text: 'Empty Storage',
                                  color: CustomColor.purple,
                                  context: context,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))
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
              if (widget.box != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                      isImported: widget.isImported,
                      box: widget.box,
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
                        isImported: widget.isImported,
                        box: widget.box,
                        deviceSize: deviceSize,
                        data: item,
                        isMove: widget.isMove,
                      ),
                    ),
                  ),
                ),
              ),
              CustomSizedBox(
                context: context,
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
