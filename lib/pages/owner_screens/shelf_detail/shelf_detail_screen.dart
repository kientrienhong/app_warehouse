import 'package:app_warehouse/common/custom_app_bar.dart';
import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/common/custom_text.dart';
import 'package:flutter/material.dart';

class ShelfDetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  ShelfDetailScreen({this.data});

  void sortList(List<Map<String, String>> list) {
    list.sort((a, b) {
      return a['position']
          .toString()
          .toLowerCase()
          .compareTo(b['position'].toString().toLowerCase());
    });
  }

  Widget _buildBox(
      {@required int index,
      @required double width,
      @required double height,
      @required Color color,
      @required EdgeInsets edgeInsets}) {
    return Container(
      margin: edgeInsets,
      height: height,
      width: width,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
    );
  }

  Widget _buildPositionRow(
      {@required List<Map<String, String>> list,
      @required String row,
      @required BuildContext context,
      @required Size deviceSize}) {
    int totalItem = 4;
    int indexItem = 0;

    list.forEach((element) {
      if (element['type'] == 'large') {
        --totalItem;
      }
    });

    return Container(
        height: deviceSize.width / 9,
        width: deviceSize.width,
        child: Row(
          children: [
            CustomText(
              text: row,
              color: CustomColor.black,
              context: context,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            CustomSizedBox(
              context: context,
              width: 17,
            ),
            Container(
                width: deviceSize.width / 1.29,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: totalItem,
                    itemBuilder: (_, index) {
                      EdgeInsets edgeInsets = index == totalItem
                          ? const EdgeInsets.only(right: 0)
                          : EdgeInsets.only(right: deviceSize.width / 12);
                      if (indexItem >= list.length) {
                        return _buildBox(
                            index: index,
                            height: deviceSize.width / 9,
                            width: deviceSize.width / 9,
                            color: CustomColor.black[3],
                            edgeInsets: edgeInsets);
                      }

                      final box = list[indexItem];

                      if (box['position'][1] == (index + 1).toString()) {
                        if (box['type'] == 'large') {
                          ++indexItem;
                          return _buildBox(
                              index: index,
                              height: deviceSize.width / 9,
                              width: deviceSize.width * 0.305,
                              color: CustomColor.lightBlue,
                              edgeInsets: edgeInsets);
                        } else {
                          ++indexItem;
                          return _buildBox(
                              index: index,
                              height: deviceSize.width / 9,
                              width: deviceSize.width / 9,
                              color: CustomColor.purple,
                              edgeInsets: edgeInsets);
                        }
                      }
                      return _buildBox(
                          index: index,
                          height: deviceSize.width / 9,
                          width: deviceSize.width / 9,
                          color: CustomColor.black[3],
                          edgeInsets: edgeInsets);
                    }))
          ],
        ));
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
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    List<Map<String, String>> listBox = data['listBox'];
    List<Map<String, String>> listA = [];
    List<Map<String, String>> listB = [];
    List<Map<String, String>> listC = [];
    List<String> numbers = ['1', '2', '3', '4'];
    listBox.forEach((element) {
      if (element['position'][0] == 'A') {
        listA.add(element);
      } else if (element['position'][0] == 'B') {
        listB.add(element);
      } else {
        listC.add(element);
      }
    });
    sortList(listA);
    sortList(listB);
    sortList(listC);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              isHome: false,
            ),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            CustomText(
              text: data['name'],
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
                                    : EdgeInsets.only(
                                        right: deviceSize.width / 6.3),
                                child: CustomText(
                                  text: numbers[index],
                                  color: CustomColor.black,
                                  context: context,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              )))
                ],
              ),
            ),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            _buildPositionRow(
                list: listA,
                row: 'A',
                context: context,
                deviceSize: deviceSize),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            _buildPositionRow(
                list: listB,
                row: 'B',
                context: context,
                deviceSize: deviceSize),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            _buildPositionRow(
                list: listC,
                row: 'C',
                context: context,
                deviceSize: deviceSize),
            CustomSizedBox(
              context: context,
              height: 24,
            ),
            Row(
              children: [
                CustomSizedBox(
                  context: context,
                  width: deviceSize.width / 12,
                ),
                Container(
                  width: deviceSize.width / 2.8,
                  child: Column(
                    children: [
                      _buildNoteForIcon(
                          name: 'Available',
                          color: CustomColor.black[3],
                          deviceSize: deviceSize,
                          context: context),
                      CustomSizedBox(
                        context: context,
                        height: 16,
                      ),
                      _buildNoteForIcon(
                          name: '0.5m x 1m x 1m',
                          color: CustomColor.purple,
                          deviceSize: deviceSize,
                          context: context),
                      CustomSizedBox(
                        context: context,
                        height: 16,
                      ),
                      _buildNoteForIcon(
                          name: '1m x 1m x 1m',
                          color: CustomColor.lightBlue,
                          deviceSize: deviceSize,
                          context: context),
                    ],
                  ),
                ),
                CustomSizedBox(
                  context: context,
                  width: 4,
                ),
                Container(
                  height: deviceSize.height / 4,
                  width: deviceSize.width / 3,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      border: Border.all(color: CustomColor.black, width: 1),
                      borderRadius: BorderRadius.circular(8)),
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
