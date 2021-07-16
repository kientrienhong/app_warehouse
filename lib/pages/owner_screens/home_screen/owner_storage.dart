import '/helpers/firebase_storage_helper.dart';
import '/models/entity/user.dart';
import '/presenters/home_presenter.dart';

import '/common/custom_color.dart';
import '/common/custom_dialog.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import '/models/entity/storage.dart';
import '/pages/owner_screens/create_storage/create_storage_screen.dart';
import '/pages/owner_screens/detail_storage/owner_detail_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class OwnerStorage extends StatefulWidget {
  final Storage data;
  final Size deviceSize;
  final HomePresenter presenter;
  OwnerStorage(
      {@required this.data,
      @required this.deviceSize,
      @required this.presenter});

  @override
  State<OwnerStorage> createState() => _OwnerStorageState();
}

class _OwnerStorageState extends State<OwnerStorage> {
  Color colorStatusChecking;

  String statusChecking;

  Future<bool> deleteStorage(BuildContext context) async {
    User user = Provider.of<User>(context, listen: false);
    bool result =
        await widget.presenter.deleteStorage(user.jwtToken, widget.data.id);
    if (result == true) {
      await FirebaseStorageHelper.deleteFolder(widget.data.id, user.email);
      Navigator.of(context).pop();
      widget.presenter.model.pagingController.refresh();
    }
    return result;
  }

  void _showDialog(BuildContext context) {
    bool isError = false;
    String msg = '';
    showDialog(
        context: context,
        builder: (_) => StatefulBuilder(
            builder: (context, setState) => CustomDeleteDialog(
                  isLoading: widget.presenter.model.isLoadingDeleteStorage,
                  title: 'Delete Storage',
                  content: 'Are you sure?',
                  isError: isError,
                  errorMsg: msg,
                  deleteFunction: () async {
                    bool result = await deleteStorage(context);
                    if (result == false) {
                      setState(() {
                        isError = true;
                        msg = 'Delete failed due to having boxes';
                      });
                    }
                  },
                )));
  }

  void _showDialogReject(BuildContext context, Size deviceSize) {
    showDialog(
        context: context,
        builder: (_) {
          return Container(
            width: deviceSize.width / 1.2,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              title: CustomText(
                text: 'Reject Reason',
                color: Colors.red,
                textAlign: TextAlign.center,
                context: context,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              content: Container(
                child: CustomText(
                    text: widget.data.rejectedReason,
                    textAlign: TextAlign.center,
                    textOverflow: TextOverflow.visible,
                    maxLines: null,
                    color: CustomColor.black[3],
                    context: context,
                    fontSize: 24),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: CustomText(
                      text: 'OK',
                      color: CustomColor.black,
                      context: context,
                      fontSize: 16,
                    ))
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String imageGallery = '';
    for (int i = 0; i < widget.data.picture.length; i++) {
      if (widget.data.picture[i]['type'] == 0) {
        imageGallery = widget.data.picture[i]['imageUrl'];
        break;
      }
    }
    final deviceSize = MediaQuery.of(context).size;
    switch (widget.data.status) {
      case 2:
        {
          colorStatusChecking = CustomColor.green;
          statusChecking = 'Approved';
          break;
        }
      case 1:
        {
          colorStatusChecking = CustomColor.orange;
          statusChecking = 'Pending';
          break;
        }
      default:
        {
          colorStatusChecking = CustomColor.red;
          statusChecking = 'Reject';
          break;
        }
    }

    return GestureDetector(
      onTap: () {
        if (widget.data.status == 2) {
          Storage currentStorage = Provider.of<Storage>(context, listen: false);
          currentStorage.setStorage(widget.data);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => OwnerDetailStorage(
                        data: widget.data,
                      )));
        } else if (widget.data.status == 3) {
          _showDialogReject(context, deviceSize);
        }
      },
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.only(bottom: 24),
          height: widget.deviceSize.height / 2.9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: CustomColor.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 14,
                    offset: Offset(0, 6),
                    color: Color(0xFF000000).withOpacity(0.06))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                child: Container(
                    width: widget.deviceSize.width,
                    height: widget.deviceSize.height / 5.2,
                    child: Image.network(
                      imageGallery,
                      fit: BoxFit.cover,
                    )),
              ),
              CustomSizedBox(
                height: 16,
                context: context,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: widget.data.name,
                      color: CustomColor.black,
                      context: context,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      text: statusChecking,
                      color: colorStatusChecking,
                      context: context,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              CustomSizedBox(
                context: context,
                height: 8,
              ),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 16),
                  child: CustomText(
                      text: widget.data.address,
                      color: CustomColor.black[2],
                      context: context,
                      maxLines: 2,
                      fontSize: 14)),
              CustomSizedBox(
                context: context,
                height: 12,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      RatingBarIndicator(
                        rating: widget.data.rating == null
                            ? 0 * 1.0
                            : widget.data.rating * 1.0,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Color(0xFFFFCC1F),
                        ),
                        itemCount: 5,
                        itemSize: 18,
                        direction: Axis.horizontal,
                      ),
                      CustomSizedBox(
                        context: context,
                        width: 4,
                      ),
                      CustomText(
                          text: '(${widget.data.numberOfRatings})',
                          color: CustomColor.black[3],
                          context: context,
                          fontSize: 16)
                    ]),
                    Row(children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Scaffold(
                                          backgroundColor: CustomColor.white,
                                          body: CreateStorageScreen(
                                            data: widget.data,
                                          ),
                                        )));
                          },
                          child: Image.asset('assets/images/edit.png')),
                      CustomSizedBox(context: context, width: 16),
                      GestureDetector(
                          onTap: () => _showDialog(context),
                          child: Image.asset('assets/images/delete.png')),
                    ])
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
