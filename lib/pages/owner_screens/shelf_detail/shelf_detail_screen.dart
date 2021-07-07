import 'package:appwarehouse/models/entity/box.dart';
import 'package:appwarehouse/models/entity/shelf.dart';
import 'package:appwarehouse/models/entity/user.dart';
import 'package:appwarehouse/pages/owner_screens/choose_storage/choose_storage_screen.dart';
import 'package:appwarehouse/presenters/shelf_detail_presenter.dart';
import 'package:appwarehouse/views/shelf_detail_view.dart';

import '/common/custom_app_bar.dart';
import '/common/custom_button.dart';
import '/common/custom_color.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ShelfDetailScreen extends StatefulWidget {
  final Shelf shelf;

  ShelfDetailScreen({this.shelf});

  @override
  State<ShelfDetailScreen> createState() => _ShelfDetailScreenState();
}

class _ShelfDetailScreenState extends State<ShelfDetailScreen>
    implements ShelfDetailView {
  ShelfDetailPresenter presenter;

  int staggeredTileBuilderIndex = 0;

  void sortList(List<Map<String, dynamic>> list) {
    list.sort((a, b) {
      return a['formatedPosition']
          .toLowerCase()
          .compareTo(b['formatedPosition'].toLowerCase());
    });
    list = list.reversed.toList();
  }

  void formatData(List<Map<String, dynamic>> listBox) {
    sortList(listBox);
    int numberLargeBox = 0;
    listBox.forEach((element) {
      int position = int.parse(element['formatedPosition']);
      element['formatedPosition'] = (position - numberLargeBox).toString();
      if (element['type'] == 'large') {
        numberLargeBox++;
      }
    });
  }

  Widget _buildBox({
    @required int index,
    @required Color color,
  }) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
    );
  }

  int checkIsLargeType(int index, List<Map<String, dynamic>> listBox) {
    final box = listBox[staggeredTileBuilderIndex];
    if (box['formatedPosition'] == index.toString()) {
      if (box['type'] == 'large') {
        return 2;
      }
    }
    return 1;
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

  @override
  void initState() {
    super.initState();
    presenter = ShelfDetailPresenter();
    presenter.view = this;
    User user = Provider.of(context, listen: false);
    presenter.fetchListBox(user.jwtToken, widget.shelf.id);
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
    int indexItem = 0;
    final deviceSize = MediaQuery.of(context).size;
    // List<Map<String, dynamic>> listBox = [...data['listBox']];

    List<String> numbers = ['1', '2', '3', '4'];
    // int totalItem = 12;
    // listBox.forEach((element) {
    //   String position = element['position'];

    //   element.putIfAbsent('formatedPosition', () {
    //     int result;
    //     int dozen;
    //     switch (position[0]) {
    //       case 'A':
    //         {
    //           dozen = 0;
    //           break;
    //         }
    //       case 'B':
    //         {
    //           dozen = 4;
    //           break;
    //         }
    //       default:
    //         {
    //           dozen = 8;
    //         }
    //     }
    //     result = dozen + int.parse(position[1]) - 1;

    //     return result.toString();
    //   });

    //   if (element['type'] == 'large') {
    //     totalItem--;
    //   }
    // });
    // formatData(listBox);

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
                            // if (indexItem >= presenter.model.listBox.length) {
                            //   return _buildBox(
                            //     index: index,
                            //     color: CustomColor.black[3],
                            //   );
                            // }

                            // final box = listBox[indexItem];
                            // if (box['formatedPosition'] == index.toString()) {
                            //   if (box['type'] == 'large') {
                            //     ++indexItem;
                            //     return _buildBox(
                            //       index: index,
                            //       color: CustomColor.lightBlue,
                            //     );
                            //   } else {
                            //     ++indexItem;
                            //     return _buildBox(
                            //       index: index,
                            //       color: CustomColor.purple,
                            //     );
                            //   }
                            // }
                            return _buildBox(
                              index: index,
                              color: CustomColor.black[3],
                            );
                          },
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.count(1, 1),
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
