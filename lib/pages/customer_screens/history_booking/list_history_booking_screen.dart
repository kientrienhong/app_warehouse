import 'package:appwarehouse/api/api_services.dart';
import 'package:appwarehouse/models/entity/order.dart';
import 'package:appwarehouse/models/entity/user.dart';
import 'package:appwarehouse/presenters/list_history_booking_presenter.dart';
import 'package:appwarehouse/views/list_history_booking_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import '/common/custom_color.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import '/pages/owner_screens/bill/bill_screen.dart';
import 'package:flutter/material.dart';

class ListHistoryBookingScreen extends StatefulWidget {
  @override
  State<ListHistoryBookingScreen> createState() =>
      _ListHistoryBookingScreenState();
}

class _ListHistoryBookingScreenState extends State<ListHistoryBookingScreen>
    implements ListHistoryBookingview {
  ListHistoryBookingPresenter presenter;
  Widget _buildBillWidget(
      {@required Order data,
      @required BuildContext context,
      @required Size deviceSize}) {
    Color colorStatus;
    String status;
    switch (data.status) {
      case 0:
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
      case 2:
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
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (_) => DetailBillScreen(
        //               data: data,
        //             )));
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
                    width: deviceSize.width / 1.7,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Container(
                                width: 48,
                                height: 48,
                                child: Image.asset(
                                  data.ownerAvatar == null
                                      ? 'asda'
                                      : data.ownerAvatar,
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
                                text: data.ownerName == null
                                    ? 'Jessica'
                                    : data.ownerName,
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
                                text: data.id.toString(),
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
                                text:
                                    data.name == null ? 'Storage 1' : data.name,
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
                                  text: data.expiredDate == null
                                      ? 'Not yet'
                                      : data.expiredDate,
                                  color: CustomColor.black,
                                  context: context,
                                  fontSize: 14),
                            ],
                          ),
                        ])),
                Column(
                  children: [
                    CustomText(
                      text: status,
                      color: colorStatus,
                      context: context,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.right,
                    ),
                    CustomSizedBox(
                      context: context,
                      height: 56,
                    ),
                    CustomText(
                      text: data.total.toString(),
                      color: CustomColor.purple,
                      context: context,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                )
              ])),
    );
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

    return Container(
      height: deviceSize.height,
      child: PagedListView<int, dynamic>(
        shrinkWrap: true,
        pagingController: presenter.model.pagingController,
        builderDelegate: PagedChildBuilderDelegate<dynamic>(
            itemBuilder: (context, item, index) => _buildBillWidget(
                data: item, deviceSize: deviceSize, context: context)),
      ),
    );
  }
}
