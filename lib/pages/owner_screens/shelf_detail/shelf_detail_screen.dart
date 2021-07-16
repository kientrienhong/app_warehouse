import 'package:appwarehouse/common/custom_input.dart';
import 'package:appwarehouse/common/custom_msg_input.dart';
import 'package:appwarehouse/models/entity/box.dart';
import 'package:appwarehouse/models/entity/imported_boxes.dart';
import 'package:appwarehouse/models/entity/moved_boxes.dart';
import 'package:appwarehouse/models/entity/order.dart';
import 'package:appwarehouse/models/entity/shelf.dart';
import 'package:appwarehouse/models/entity/storage.dart';
import 'package:appwarehouse/models/entity/user.dart';
import 'package:appwarehouse/pages/owner_screens/choose_storage/choose_storage_screen.dart';
import 'package:appwarehouse/presenters/shelf_detail_presenter.dart';
import 'package:appwarehouse/views/shelf_detail_view.dart';
import 'package:flutter/cupertino.dart';

import '/common/custom_app_bar.dart';
import '/common/custom_button.dart';
import '/common/custom_color.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

enum TypeBox { small, big }

class ShelfDetailScreen extends StatefulWidget {
  final Shelf shelf;
  bool isMove;
  final bool isImported;
  ShelfDetailScreen(
      {this.shelf, @required this.isMove, @required this.isImported});

  @override
  State<ShelfDetailScreen> createState() => _ShelfDetailScreenState();
}

class _ShelfDetailScreenState extends State<ShelfDetailScreen>
    implements ShelfDetailView {
  ShelfDetailPresenter presenter;
  TypeBox current = TypeBox.big;
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  int staggeredTileBuilderIndex = 0;

  Widget _buildNoteForIconDialog(
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

  Widget _buildNoteForIcon(
      {@required String name,
      @required Color color,
      @required Size deviceSize,
      @required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: deviceSize.width / 12,
          width: deviceSize.width / 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
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

  _showMoveBox(Size deviceSize) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: CustomText(
                  text: 'Move box',
                  color: CustomColor.black,
                  context: context,
                  fontSize: 24),
              content: Container(
                height: deviceSize.height / 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                        height: 32,
                        text: 'Move in same shelf',
                        width: double.infinity,
                        isLoading: false,
                        textColor: CustomColor.green,
                        onPressFunction: () {
                          MovedBoxes movedBoxes =
                              Provider.of<MovedBoxes>(context, listen: false);
                          movedBoxes.setMovedBoxes(movedBoxes.copyWith(
                              isMoveSamePlace: true,
                              movedBox: presenter.model
                                  .listBox[presenter.model.currentIndex]));
                          widget.isMove = true;
                          Navigator.pop(context);
                        },
                        buttonColor: CustomColor.lightBlue,
                        borderRadius: 4),
                    CustomSizedBox(context: context, height: 8),
                    CustomButton(
                        height: 32,
                        text: 'Move to another place',
                        width: double.infinity,
                        isLoading: false,
                        textColor: CustomColor.white,
                        onPressFunction: () {
                          Box box = presenter
                              .model.listBox[presenter.model.currentIndex];
                          MovedBoxes movedBoxes =
                              Provider.of<MovedBoxes>(context, listen: false);
                          movedBoxes.setMovedBoxes(
                              movedBoxes.copyWith(movedBox: box));
                          widget.isMove = true;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChooseStorageScreen(
                                        isImported: false,
                                        isMove: true,
                                        box: box,
                                        idPreviousStorage:
                                            widget.shelf.storageId,
                                      )));
                        },
                        buttonColor: CustomColor.purple,
                        borderRadius: 4),
                  ],
                ),
              ),
            ));
  }

  _showDialogUndo(Box box, int indexFoundBoxes, Size deviceSize) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: CustomText(
            text: 'Undo',
            color: CustomColor.black,
            context: context,
            fontSize: 24),
        content: Container(
            height: deviceSize.height / 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                    text: 'Are you sure?',
                    color: CustomColor.black,
                    context: context,
                    fontSize: 24),
                CustomSizedBox(
                  context: context,
                  height: 16,
                ),
                CustomButton(
                    height: 32,
                    text: 'Undo',
                    width: double.infinity,
                    isLoading: false,
                    textColor: CustomColor.green,
                    onPressFunction: () {
                      Order order = Provider.of<Order>(context, listen: false);
                      ImportedBoxes importedBoxes =
                          Provider.of<ImportedBoxes>(context, listen: false);
                      importedBoxes.undoBox(
                          box, indexFoundBoxes, widget.shelf.id);
                      if (box.type == 1) {
                        int quantity = order.smallBoxQuantity + 1;
                        order.setOrder(
                            order.copyWith(smallBoxQuantity: quantity));
                      } else {
                        int quantity = order.bigBoxQuantity + 1;
                        order
                            .setOrder(order.copyWith(bigBoxQuantity: quantity));
                      }
                      updateGridView(
                          importedBoxes.importedShelves[widget.shelf.id]);
                      Navigator.of(context).pop();
                    },
                    buttonColor: CustomColor.lightBlue,
                    borderRadius: 4)
              ],
            )),
      ),
    );
  }

  _showDialog(Size deviceSize, int idBox, int index) {
    if (widget.isImported == true) {
      Order order = Provider.of<Order>(context, listen: false);

      showDialog(
          context: context,
          builder: (_) => StatefulBuilder(
                builder: (context, setState) => AlertDialog(
                  content: Container(
                    height: deviceSize.height / 3,
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                  text: 'Order',
                                  color: CustomColor.black,
                                  context: context,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                              CustomSizedBox(context: context, width: 4),
                              CustomText(
                                  text: 'Id: #${order.id.toString()}',
                                  color: CustomColor.black,
                                  context: context,
                                  fontSize: 16),
                            ]),
                        CustomSizedBox(
                          context: context,
                          height: 4,
                        ),
                        CustomText(
                            text: 'Type Box',
                            color: CustomColor.black,
                            context: context,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        CustomSizedBox(context: context, height: 4),
                        ListTile(
                          title: _buildNoteForIconDialog(
                              name: '1m x 1m x 2m',
                              color: CustomColor.lightBlue,
                              quantity: order.bigBoxQuantity,
                              deviceSize: deviceSize,
                              context: context),
                          leading: Radio(
                            value: TypeBox.big,
                            groupValue: current,
                            onChanged: (TypeBox value) {
                              setState(() {
                                current = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: _buildNoteForIconDialog(
                              name: '0.5m x 1m x 2m',
                              color: CustomColor.purple,
                              quantity: order.smallBoxQuantity,
                              deviceSize: deviceSize,
                              context: context),
                          leading: Radio(
                            value: TypeBox.small,
                            groupValue: current,
                            onChanged: (TypeBox value) {
                              setState(() {
                                current = value;
                              });
                            },
                          ),
                        ),
                        CustomButton(
                            height: 32,
                            text: 'Submit',
                            width: double.infinity,
                            isLoading: false,
                            textColor: CustomColor.green,
                            onPressFunction: () {
                              int type = -1;
                              if (current == TypeBox.small) {
                                type = 1;
                                if (order.smallBoxQuantity == 0) {
                                  return;
                                }
                                int quantity = order.smallBoxQuantity - 1;
                                order.setOrder(
                                    order.copyWith(smallBoxQuantity: quantity));
                              }

                              if (current == TypeBox.big) {
                                type = 2;
                                List<Box> listBox = presenter.model.listBox;

                                if (listBox[index].position[1] == '4') {
                                  return;
                                }

                                if (listBox[index + 1].status == 2) {
                                  return;
                                }

                                if (order.bigBoxQuantity == 0) {
                                  return;
                                }
                                int quantity = order.bigBoxQuantity - 1;
                                order.setOrder(
                                    order.copyWith(bigBoxQuantity: quantity));
                              }
                              List<Box> listBox = presenter.model.listBox;
                              double price = type == 1
                                  ? order.smallBoxPrice
                                  : order.bigBoxPrice;
                              ImportedBoxes importedBoxes =
                                  Provider.of<ImportedBoxes>(context,
                                      listen: false);
                              Storage storage =
                                  Provider.of<Storage>(context, listen: false);
                              int indexCurrentBox =
                                  listBox.indexWhere((e) => e.id == idBox);

                              if (type == 2) {
                                listBox.remove(listBox.firstWhere(
                                    (element) => element.id == (idBox + 1)));
                              }
                              listBox[indexCurrentBox] =
                                  listBox[indexCurrentBox].copyWith(
                                      type: type, status: 2, price: price);
                              importedBoxes.addShelf(
                                  widget.shelf.id, listBox, idBox);

                              importedBoxes.addBox({
                                "boxId": idBox,
                                "orderId": order.id,
                                "price": price,
                                "type": type,
                                'boxCode':
                                    '${order.id}_${type}_${importedBoxes.listResult.length}',
                                "boxId2": type == 2 ? idBox + 1 : null,
                              }, storage.id == widget.shelf.storageId);
                              updateGridView(listBox);

                              Navigator.pop(context);
                            },
                            buttonColor: CustomColor.lightBlue,
                            borderRadius: 4)
                      ],
                    ),
                  ),
                ),
              ));
    }
  }

  _showDialogWriteReasonMove(Box box, Size deviceSize) {
    bool isLoading = false;
    String msg = '';
    bool isError = false;
    showDialog(
        context: context,
        builder: (_) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                title: CustomText(
                  text: 'Reason move another storage',
                  color: Colors.black,
                  textAlign: TextAlign.center,
                  context: context,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                content: Container(
                  height: deviceSize.height / 4,
                  child: Column(
                    children: [
                      CustomOutLineInput(
                          isDisable: false,
                          controller: textEditingController,
                          focusNode: focusNode,
                          deviceSize: deviceSize,
                          labelText: 'Reason'),
                      if (msg.isNotEmpty)
                        CustomMsgInput(msg: msg, isError: isError, maxLines: 2),
                      CustomSizedBox(
                        context: context,
                        height: 4,
                      ),
                      CustomButton(
                          height: 32,
                          text: 'Submit',
                          width: double.infinity,
                          isLoading: isLoading,
                          textColor: CustomColor.green,
                          onPressFunction: () async {
                            if (textEditingController.text.isEmpty) {
                              setState(() {
                                msg = 'You must provide reason';
                                isError = true;
                              });
                              return;
                            }

                            setState(() {
                              isLoading = true;
                            });
                            MovedBoxes movedBoxes =
                                Provider.of<MovedBoxes>(context, listen: false);
                            await changePosition(movedBoxes.movedBox, box.id,
                                textEditingController.text);
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pop(context);
                          },
                          buttonColor: CustomColor.lightBlue,
                          borderRadius: 4)
                    ],
                  ),
                ));
          });
        });
  }

  Widget _buildBox({
    @required int index,
    @required Box box,
    @required int idOrder,
    @required Color color,
    @required Size deviceSize,
  }) {
    return GestureDetector(
      onTap: () async {
        MovedBoxes movedBoxes = Provider.of<MovedBoxes>(context, listen: false);
        if (color == CustomColor.black[3] && widget.isImported == true) {
          _showDialog(deviceSize, box.id, index);
          return;
        }

        if (color == CustomColor.green && widget.isImported == true) {
          ImportedBoxes importedBoxes =
              Provider.of<ImportedBoxes>(context, listen: false);

          try {
            int indexFoundBoxes = importedBoxes.listResult
                .indexWhere((e) => e['boxId'] == box.id);
            _showDialogUndo(box, indexFoundBoxes, deviceSize);
          } catch (e) {}
          return;
        }

        if (widget.isMove == false && box.status == 2) {
          onClickBox(index, idOrder);
          return;
        }

        if (widget.isMove == true &&
            box.status == 2 &&
            presenter.model.currentIndex == index) {
          //TODO
          _showMoveBox(deviceSize);
        }

        if (widget.isMove == true &&
            box.status == 1 &&
            movedBoxes.movedBox != null &&
            movedBoxes.isMoveSamePlace == false) {
          _showDialogWriteReasonMove(box, deviceSize);
        }

        if (widget.isMove == true &&
            box.status == 1 &&
            movedBoxes.movedBox != null &&
            movedBoxes.isMoveSamePlace == true) {
          //TODO
          final snackBar = SnackBar(
            content: Text('Can not place!'),
          );
          if (movedBoxes.movedBox.type == 2) {
            if (presenter.model.listBox[index + 1].status != 1) {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
            }
            if (box.position[1] == '4') {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return;
            }
          }
          changePosition(movedBoxes.movedBox, box.id, null);
        }
      },
      child: Container(
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    presenter = ShelfDetailPresenter();
    presenter.view = this;
    User user = Provider.of(context, listen: false);
    ImportedBoxes importedBoxes =
        Provider.of<ImportedBoxes>(context, listen: false);

    if (widget.isMove == true) {
      Storage storage = Provider.of<Storage>(context, listen: false);
      MovedBoxes movedBoxes = Provider.of<MovedBoxes>(context, listen: false);
      if (storage.id != widget.shelf.storageId) {
        movedBoxes.setMovedBoxes(movedBoxes.copyWith(
          isMoveSamePlace: false,
        ));
      } else {
        movedBoxes.setMovedBoxes(movedBoxes.copyWith(
          isMoveSamePlace: true,
        ));
      }
    }

    if (importedBoxes.importedShelves.containsKey(widget.shelf.id)) {
      presenter.model.listBox = importedBoxes.importedShelves[widget.shelf.id];
    } else {
      presenter.fetchListBox(user.jwtToken, widget.shelf.id);
    }
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    focusNode.dispose();
  }

  @override
  Future<void> changePosition(Box box, int newIdBox, String msg) async {
    User user = Provider.of<User>(context, listen: false);
    bool result =
        await presenter.changePosition(box, newIdBox, user.jwtToken, msg);
    if (result == true) {
      final snackBar = SnackBar(
        content: Text('Move sucessful'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      presenter.model.currentIndex = -1;
      presenter.fetchListBox(user.jwtToken, widget.shelf.id);
      MovedBoxes movedBoxes = Provider.of<MovedBoxes>(context, listen: false);
      movedBoxes.setMovedBoxes(MovedBoxes.empty());
      widget.isMove = false;
    }
  }

  @override
  void updateLoading() {
    setState(() {
      presenter.model.isLoading = !presenter.model.isLoading;
    });
  }

  @override
  void updateLoadingOrder() {
    setState(() {
      presenter.model.isLoadingOrder = !presenter.model.isLoadingOrder;
    });
  }

  @override
  void updateInfoOrder(Map<String, dynamic> info) {
    setState(() {
      presenter.model.infoOrder = info;
    });
  }

  @override
  void onClickBox(int index, int idOrder) {
    setState(() {
      presenter.model.currentIndex = index;
    });
    User user = Provider.of<User>(context, listen: false);
    presenter.fetchOrder(user.jwtToken, idOrder, true);
  }

  @override
  void removeBox(Box box) {}

  @override
  void onClickMoveBox() {
    Box box = presenter.model.listBox[presenter.model.currentIndex];
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ChooseStorageScreen(
                  box: box,
                  isMove: true,
                  idPreviousStorage: widget.shelf.storageId,
                )));
  }

  @override
  void onClickRemoveBox() {}

  @override
  void updateMsg(String msg, bool isError) {
    setState(() {
      presenter.model.msg = msg;
      presenter.model.isError = isError;
    });
  }

  @override
  void updateGridView(List<Box> listBox) {
    setState(() {
      presenter.model.listBox = listBox;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    User user = Provider.of<User>(context, listen: false);
    List<String> numbers = ['1', '2', '3', '4'];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            CustomAppBar(
              isHome: false,
            ),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            CustomText(
              text: 'Shelf - ' + widget.shelf.id.toString(),
              color: CustomColor.black,
              context: context,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            CustomSizedBox(
              context: context,
              height: 32,
            ),
            Container(
              width: deviceSize.width,
              height: deviceSize.height / 20,
              child: Row(
                children: [
                  CustomSizedBox(
                    context: context,
                    width: 46,
                  ),
                  Container(
                    width: deviceSize.width / 1.4,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: numbers.length,
                      itemBuilder: (_, index) => Container(
                        margin: index == 3
                            ? const EdgeInsets.only(right: 0)
                            : EdgeInsets.only(right: deviceSize.width / 6.3),
                        child: CustomText(
                          text: numbers[index],
                          color: CustomColor.black,
                          context: context,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            presenter.model.isLoading == false
                ? Container(
                    margin: EdgeInsets.only(top: 16),
                    child: Row(children: [
                      Container(
                        height: deviceSize.height / 3.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: 'A',
                                color: CustomColor.black,
                                fontWeight: FontWeight.bold,
                                context: context,
                                fontSize: 24),
                            CustomSizedBox(
                              context: context,
                              height: 24,
                            ),
                            CustomText(
                                text: 'B',
                                color: CustomColor.black,
                                fontWeight: FontWeight.bold,
                                context: context,
                                fontSize: 24),
                            CustomSizedBox(
                              context: context,
                              height: 24,
                            ),
                            CustomText(
                                text: 'C',
                                color: CustomColor.black,
                                fontWeight: FontWeight.bold,
                                context: context,
                                fontSize: 24),
                            CustomSizedBox(
                              context: context,
                              height: 24,
                            ),
                          ],
                        ),
                      ),
                      CustomSizedBox(
                        context: context,
                        width: 14,
                      ),
                      Consumer<MovedBoxes>(
                        builder: (context, item, child) => Container(
                          height: deviceSize.height / 2.8,
                          width: deviceSize.width / 1.4,
                          child: StaggeredGridView.countBuilder(
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: presenter.model.listBox.length,
                            itemBuilder: (BuildContext context, int index) {
                              List<Box> listBox = presenter.model.listBox;
                              Box box = listBox[index];

                              Order order;

                              if (index == presenter.model.currentIndex ||
                                  box.isModified == true) {
                                return _buildBox(
                                  deviceSize: deviceSize,
                                  box: box,
                                  idOrder: box.orderId,
                                  index: index,
                                  color: CustomColor.green,
                                );
                              }

                              if (box.status == 2 &&
                                  presenter.model.listOrder.length > 0) {
                                order = presenter.model.listOrder
                                    .firstWhere((e) => e.id == box.orderId);
                                DateTime expiredDate = DateFormat('yyyy-MM-dd')
                                    .parse(order.expiredDate.split('T')[0]);
                                DateTime now = DateTime.now();
                                if (expiredDate.isBefore(now)) {
                                  return _buildBox(
                                    deviceSize: deviceSize,
                                    box: box,
                                    idOrder: box.orderId,
                                    index: index,
                                    color: CustomColor.red,
                                  );
                                }

                                if (expiredDate.difference(now).inDays <= 3) {
                                  return _buildBox(
                                    deviceSize: deviceSize,
                                    box: box,
                                    idOrder: box.orderId,
                                    index: index,
                                    color: CustomColor.orange,
                                  );
                                }
                              }

                              if (box.type == 1) {
                                return _buildBox(
                                  deviceSize: deviceSize,
                                  box: box,
                                  index: index,
                                  idOrder: box.orderId,
                                  color: CustomColor.purple,
                                );
                              }

                              if (box.type == 2) {
                                return _buildBox(
                                  deviceSize: deviceSize,
                                  box: box,
                                  index: index,
                                  idOrder: box.orderId,
                                  color: CustomColor.lightBlue,
                                );
                              }

                              return _buildBox(
                                index: index,
                                deviceSize: deviceSize,
                                idOrder: box.orderId,
                                box: box,
                                color: CustomColor.black[3],
                              );
                            },
                            staggeredTileBuilder: (int index) =>
                                new StaggeredTile.count(
                                    presenter.model.listBox[index].type == 2
                                        ? 2
                                        : 1,
                                    1),
                            mainAxisSpacing: 8.0,
                            crossAxisSpacing: 12.0,
                          ),
                        ),
                      ),
                    ]),
                  )
                : SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(CustomColor.purple),
                    ),
                  ),
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: deviceSize.width / 2.8,
                    child: _buildNoteForIcon(
                        name: '1m x 1m x 1m',
                        color: CustomColor.lightBlue,
                        deviceSize: deviceSize,
                        context: context),
                  ),
                  Container(
                    width: deviceSize.width / 2.8,
                    child: _buildNoteForIcon(
                        name: '0.5m x 1m x 1m',
                        color: CustomColor.purple,
                        deviceSize: deviceSize,
                        context: context),
                  ),
                ],
              ),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: deviceSize.width / 2.8,
                    child: _buildNoteForIcon(
                        name: 'Available',
                        color: CustomColor.black[3],
                        deviceSize: deviceSize,
                        context: context),
                  ),
                  Container(
                    width: deviceSize.width / 2.8,
                    child: _buildNoteForIcon(
                        name: 'Selected',
                        color: CustomColor.green,
                        deviceSize: deviceSize,
                        context: context),
                  ),
                ],
              ),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: deviceSize.width / 2.8,
                    child: _buildNoteForIcon(
                        name: 'Expired soon',
                        color: CustomColor.orange,
                        deviceSize: deviceSize,
                        context: context),
                  ),
                  Container(
                    width: deviceSize.width / 2.8,
                    child: _buildNoteForIcon(
                        name: 'Expired',
                        color: CustomColor.red,
                        deviceSize: deviceSize,
                        context: context),
                  ),
                ],
              )
            ]),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            Container(
              width: deviceSize.width / 3,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  border: Border.all(color: CustomColor.black, width: 1),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(children: [
                presenter.model.isLoadingOrder == false
                    ? Container(
                        width: deviceSize.width / 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Order Id',
                              color: CustomColor.black,
                              context: context,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomSizedBox(
                              context: context,
                              height: 4,
                            ),
                            CustomText(
                              text: presenter.model.infoOrder['id'],
                              color: CustomColor.black,
                              context: context,
                              fontSize: 14,
                            ),
                            CustomSizedBox(
                              context: context,
                              height: 16,
                            ),
                            CustomText(
                              text: 'Time remain',
                              color: CustomColor.black,
                              context: context,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            CustomSizedBox(
                              context: context,
                              height: 4,
                            ),
                            CustomText(
                              text: presenter.model.infoOrder['dateRemain'],
                              color: CustomColor.black,
                              context: context,
                              maxLines: 2,
                              fontSize: 14,
                            ),
                          ],
                        ),
                      )
                    : SizedBox(
                        height: deviceSize.width / 3,
                        width: deviceSize.width / 3,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(CustomColor.purple),
                        ),
                      ),
                CustomSizedBox(context: context, width: 16),
                Column(
                  children: [
                    CustomButton(
                        height: 32,
                        isLoading: false,
                        text: 'Move',
                        width: deviceSize.width / 3,
                        textColor: CustomColor.green,
                        onPressFunction: () {
                          if (presenter.model.currentIndex != -1)
                            _showMoveBox(deviceSize);
                        },
                        buttonColor: CustomColor.lightBlue,
                        borderRadius: 4),
                  ],
                )
              ]),
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
