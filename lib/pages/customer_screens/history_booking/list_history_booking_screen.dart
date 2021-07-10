import 'package:appwarehouse/common/bill_widget.dart';
import 'package:appwarehouse/common/custom_app_bar.dart';
import 'package:appwarehouse/common/custom_button.dart';

import '/models/entity/order.dart';
import '/models/entity/user.dart';
import '/presenters/list_history_booking_presenter.dart';
import '/views/list_history_booking_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import '/common/custom_color.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListHistoryBookingScreen extends StatefulWidget {
  @override
  State<ListHistoryBookingScreen> createState() =>
      _ListHistoryBookingScreenState();
}

class _ListHistoryBookingScreenState extends State<ListHistoryBookingScreen>
    implements ListHistoryBookingview {
  ListHistoryBookingPresenter presenter;
  String restrictFractionalSeconds(String dateTime) =>
      dateTime.replaceFirstMapped(RegExp(r"(\.\d{6})\d+"), (m) => m[1]);

  Widget _buildBillWidget(
      {@required Order data,
      @required BuildContext context,
      @required Size deviceSize}) {
    Color colorStatus;
    String status;
    DateFormat dateFormater = DateFormat('yyyy-MM-dd');
    switch (data.status) {
      case 3:
        {
          colorStatus = CustomColor.green;
          status = 'Check out';
          break;
        }
      case 1:
        {
          colorStatus = CustomColor.purple;
          status = 'Paid';
          break;
        }
      case 4:
        {
          colorStatus = CustomColor.red;
          status = 'Time out';
          break;
        }
      default:
        {
          colorStatus = CustomColor.blue;
          status = 'Deliveried';
          break;
        }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => Scaffold(
                      body: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SingleChildScrollView(
                          child: Column(children: [
                            CustomAppBar(
                              isHome: false,
                            ),
                            BillWidget(
                              data: data,
                            ),
                            CustomSizedBox(context: context, height: 24)
                          ]),
                        ),
                      ),
                    )));
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
              color: CustomColor.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    blurRadius: 14,
                    offset: Offset(0, 6),
                    color: Colors.black.withOpacity(0.06))
              ]),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: deviceSize.width / 2.3,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Container(
                                width: 48,
                                height: 48,
                                child: Image.network(
                                  data.ownerAvatar,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          CustomSizedBox(
                            context: context,
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: data.ownerName,
                                color: CustomColor.black,
                                context: context,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomSizedBox(
                                context: context,
                                height: 8,
                              ),
                              CustomText(
                                text: '#' + data.id.toString(),
                                color: CustomColor.black,
                                context: context,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              CustomSizedBox(
                                context: context,
                                height: 8,
                              ),
                              CustomText(
                                text: data.name,
                                color: CustomColor.black,
                                context: context,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ])),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(
                      text: status,
                      color: colorStatus,
                      context: context,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.right,
                    ),
                    CustomSizedBox(
                      context: context,
                      height: 8,
                    ),
                    CustomText(
                        text: 'Expired date: ' +
                            DateFormat('dd/MM/yyyy').format(dateFormater
                                .parse(data.expiredDate.split('T')[0])),
                        color: CustomColor.black,
                        maxLines: 2,
                        context: context,
                        textAlign: TextAlign.right,
                        fontSize: 14),
                    CustomSizedBox(
                      context: context,
                      height: 8,
                    ),
                    CustomText(
                      text: data.total.toString() + ' VND',
                      color: CustomColor.purple,
                      textAlign: TextAlign.right,
                      context: context,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                )
              ])),
    );
  }

  @override
  void updateListView() {
    setState(() {});
  }

  @override
  updateLoading() {
    setState(() {
      presenter.model.isLoading = !presenter.model.isLoading;
    });
  }

  @override
  void fetchPage(int pageKey) async {
    User user = Provider.of<User>(context, listen: false);
    presenter.loadListHistoryBooking(pageKey, 10, user.jwtToken);
  }

  @override
  void initState() {
    super.initState();
    presenter = ListHistoryBookingPresenter();
    presenter.view = this;
    presenter.model.pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return presenter.model.pagingController.error == null
        ? Container(
            height: deviceSize.height,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: RefreshIndicator(
              onRefresh: () =>
                  Future.sync(() => presenter.model.pagingController.refresh()),
              child: PagedListView<int, dynamic>(
                shrinkWrap: true,
                pagingController: presenter.model.pagingController,
                builderDelegate: PagedChildBuilderDelegate<dynamic>(
                    itemBuilder: (context, item, index) => _buildBillWidget(
                        data: item, deviceSize: deviceSize, context: context)),
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                      text: 'Not have bill yet!',
                      color: CustomColor.black[3],
                      context: context,
                      fontSize: 24),
                  CustomSizedBox(
                    context: context,
                    height: 16,
                  ),
                  CustomButton(
                      height: 32,
                      text: 'Refresh',
                      width: double.infinity,
                      isLoading: presenter.model.isLoading,
                      textColor: CustomColor.white,
                      onPressFunction: () async {
                        try {
                          presenter.view.updateLoading();
                          fetchPage(
                            0,
                          );
                        } catch (e) {
                          print(e.toString());
                        } finally {
                          presenter.view.updateLoading();
                          presenter.view.updateListView();
                        }
                      },
                      buttonColor: CustomColor.purple,
                      borderRadius: 4),
                ]),
          );
  }
}
