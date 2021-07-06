import 'package:appwarehouse/common/custom_button.dart';
import 'package:appwarehouse/models/entity/order_customer.dart';
import 'package:appwarehouse/models/entity/user.dart';
import 'package:appwarehouse/presenters/bill_presenter.dart';
import 'package:appwarehouse/views/bill_view.dart';

import '/common/custom_color.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

enum StatusBill { PAID, DELIVERIED, CHECK_OUT, TIME_OUT }

class BillScreen extends StatefulWidget {
  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> implements BillView {
  BillPresenter presenter;
  final oCcy = new NumberFormat("#,##0", "en_US");

  Widget _buildBillWidget(
      {@required OrderCustomer data,
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
                                child: Image.network(
                                  data.customerAvatar,
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
                                text: data.customerName,
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
                              CustomSizedBox(
                                context: context,
                                height: 8,
                              ),
                              // CustomText(
                              //     text: 'Expired Date: ' + data.,
                              //     color: CustomColor.black,
                              //     context: context,
                              //     fontSize: 14),
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
                      text: oCcy.format(data.total) + ' VND',
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
  void initState() {
    super.initState();
    presenter = BillPresenter();
    presenter.view = this;
    presenter.model.pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }

  @override
  void updateView() {
    setState(() {});
  }

  @override
  void fetchPage(int pageKey) {
    User user = Provider.of<User>(context, listen: false);
    presenter.fetchPage(pageKey, user.jwtToken, 5);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(children: [
        CustomSizedBox(
          context: context,
          height: 16,
        ),
        presenter.model.pagingController.error == null
            ? Container(
                height: deviceSize.height / 1.3,
                child: RefreshIndicator(
                  onRefresh: () => Future.sync(
                      () => presenter.model.pagingController.refresh()),
                  child: PagedListView<int, OrderCustomer>(
                    shrinkWrap: true,
                    pagingController: presenter.model.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<OrderCustomer>(
                        itemBuilder: (context, item, index) => _buildBillWidget(
                            data: item,
                            context: context,
                            deviceSize: deviceSize)),
                  ),
                ),
              )
            : Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                CustomText(
                    text: 'Not have customer order yet!',
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
                    isLoading: false,
                    textColor: CustomColor.white,
                    onPressFunction: () async {
                      fetchPage(0);
                    },
                    buttonColor: CustomColor.purple,
                    borderRadius: 4),
              ]),
        CustomSizedBox(
          context: context,
          height: 32,
        )
      ]),
    );
  }
}
