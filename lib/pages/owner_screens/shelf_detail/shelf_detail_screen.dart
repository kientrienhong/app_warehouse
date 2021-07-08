import 'package:appwarehouse/models/entity/box.dart';
import 'package:appwarehouse/models/entity/imported_boxes.dart';
import 'package:appwarehouse/models/entity/order.dart';
import 'package:appwarehouse/models/entity/shelf.dart';
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

enum TypeBox { small, big }

class ShelfDetailScreen extends StatefulWidget {
  final Shelf shelf;
  final bool isMove;
  ShelfDetailScreen({this.shelf, @required this.isMove});

  @override
  State<ShelfDetailScreen> createState() => _ShelfDetailScreenState();
}

class _ShelfDetailScreenState extends State<ShelfDetailScreen>
    implements ShelfDetailView {
  ShelfDetailPresenter presenter;
  TypeBox current = TypeBox.big;
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

  _showDialog(Size deviceSize, int idBox) {
    if (widget.isMove == false) {
      return;
    }

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
                            int indexCurrentBox =
                                listBox.indexWhere((e) => e.id == idBox);

                            if (type == 2) {
                              listBox.remove(listBox.firstWhere(
                                  (element) => element.id == (idBox + 1)));
                            }
                            listBox[indexCurrentBox] = listBox[indexCurrentBox]
                                .copyWith(type: type, status: 2, price: price);
                            importedBoxes.addShelf(widget.shelf.id, listBox);
                            importedBoxes.addBox({
                              "boxId": idBox,
                              "orderId": order.id,
                              "price": price,
                              "type": type,
                              'boxCode':
                                  '${order.id}_${type}_${importedBoxes.listResult.length}',
                              "boxId2": type == 2 ? idBox + 1 : null
                            });
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

  Widget _buildBox({
    @required int idBox,
    @required int index,
    @required Color color,
    @required Size deviceSize,
  }) {
    return GestureDetector(
      onTap: () {
        if (color == CustomColor.black[3]) {
          _showDialog(deviceSize, idBox);
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
    if (importedBoxes.importedShelves.containsKey(widget.shelf.id)) {
      presenter.model.listBox = importedBoxes.importedShelves[widget.shelf.id];
    } else {
      presenter.fetchListBox(user.jwtToken, widget.shelf.id);
    }
  }

  @override
  void updateLoading() {
    setState(() {
      presenter.model.isLoading = !presenter.model.isLoading;
    });
  }

  @override
  void onClickBox() {}

  @override
  void onClickMoveBox() {}

  @override
  void onClickRemoveBox() {}

  @override
  void updateGridView(List<Box> listBox) {
    setState(() {
      presenter.model.listBox = listBox;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

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
                      Container(
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
                            if (box.type == 1) {
                              return GestureDetector(
                                onTap: () {
                                  if (widget.isMove == false) {}
                                },
                                child: _buildBox(
                                  deviceSize: deviceSize,
                                  idBox: box.id,
                                  index: index,
                                  color: CustomColor.purple,
                                ),
                              );
                            }

                            if (box.type == 2) {
                              return GestureDetector(
                                onTap: () {
                                  if (widget.isMove == false) {}
                                },
                                child: _buildBox(
                                  deviceSize: deviceSize,
                                  idBox: box.id,
                                  index: index,
                                  color: CustomColor.lightBlue,
                                ),
                              );
                            }

                            return _buildBox(
                              idBox: listBox[index].id,
                              index: index,
                              deviceSize: deviceSize,
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
                    ]),
                  )
                : SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
                Column(
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
                      text: 'R001',
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
                      text: '1 Month - 1 Week - 4 Days',
                      color: CustomColor.black,
                      context: context,
                      maxLines: 2,
                      fontSize: 14,
                    ),
                  ],
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ChooseStorageScreen(
                                        box: presenter.model.listBox[0],
                                        idPreviousStorage:
                                            widget.shelf.storageId,
                                      )));
                        },
                        buttonColor: CustomColor.lightBlue,
                        borderRadius: 4),
                    CustomSizedBox(
                      context: context,
                      height: 16,
                    ),
                    CustomButton(
                        height: 32,
                        text: 'Remove',
                        width: deviceSize.width / 3,
                        textColor: CustomColor.white,
                        onPressFunction: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (_) => ChooseSelfScreen()));
                        },
                        buttonColor: CustomColor.red,
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
