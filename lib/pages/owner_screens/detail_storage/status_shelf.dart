import 'package:appwarehouse/common/custom_dialog.dart';
import 'package:appwarehouse/models/entity/box.dart';
import 'package:appwarehouse/pages/owner_screens/shelf_detail/shelf_detail_screen.dart';
import 'package:appwarehouse/presenters/owner_detail_storage_presenter.dart';
import 'package:provider/provider.dart';
import '/models/entity/shelf.dart';

import '/common/custom_color.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StatusShelf extends StatefulWidget {
  final Size deviceSize;
  final Shelf data;
  final Box box;
  final bool isMove;
  final bool isImported;
  final OwnerDetailStoragePresenter presenter;
  StatusShelf(
      {@required this.presenter,
      @required this.deviceSize,
      this.box,
      @required this.isImported,
      this.isMove: false,
      @required this.data});

  @override
  State<StatusShelf> createState() => _StatusShelfState();
}

class _StatusShelfState extends State<StatusShelf> {
  void _showDialog(BuildContext context, int idShelf) {
    bool isError = false;
    String msg = '';
    bool isLoading = false;
    showDialog(
        context: context,
        builder: (_) => StatefulBuilder(
            builder: (context, setState) => CustomDeleteDialog(
                  isLoading: false,
                  title: 'Delete Shelf',
                  content: 'Are you sure?',
                  isError: isError,
                  errorMsg: msg,
                  deleteFunction: () async {
                    setState(() {
                      isLoading = true;
                    });
                    bool result = await widget.presenter.view
                        .onHandleDeleteShelf(idShelf);
                    if (result == false) {
                      setState(() {
                        isError = true;
                        msg = 'Delete failed due to having boxes';
                      });
                    }

                    setState(() {
                      isLoading = false;
                    });
                  },
                )));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Shelf shelf = Provider.of<Shelf>(context, listen: false);
        shelf.setShelf(widget.data);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ShelfDetailScreen(
                      isMove: widget.isMove,
                      isImported: widget.isImported,
                      shelf: widget.data,
                    )));
      },
      child: Container(
        height: widget.deviceSize.height / 18,
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: widget.deviceSize.height / 18,
              width: widget.deviceSize.width / 4.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: CustomColor.lightBlue),
              child: Center(
                child: CustomText(
                  text: 'Shelf - ' + widget.data.id.toString(),
                  color: CustomColor.black,
                  context: context,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CustomSizedBox(
              context: context,
              width: 16,
            ),
            CustomText(
                text: 'Used',
                color: CustomColor.black[2],
                context: context,
                fontSize: 16),
            CustomSizedBox(
              context: context,
              width: 4,
            ),
            new LinearPercentIndicator(
              width: widget.deviceSize.width / 3,
              lineHeight: 8,
              backgroundColor: CustomColor.lightBlue,
              percent: widget.data.usage.toDouble() / 100,
              progressColor: CustomColor.purple,
            ),
            CustomSizedBox(
              context: context,
              width: 2,
            ),
            CustomText(
                text: widget.data.usage.toString() + '%',
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 16),
            if (widget.data.usage == 0)
              CustomSizedBox(
                context: context,
                width: 8,
              ),
            if (widget.data.usage == 0 &&
                widget.isMove == false &&
                widget.isImported == false)
              GestureDetector(
                onTap: () => _showDialog(context, widget.data.id),
                child: Container(
                    height: 24,
                    width: 24,
                    child: Image.asset('assets/images/delete.png',
                        fit: BoxFit.cover)),
              )
          ],
        ),
      ),
    );
  }
}
