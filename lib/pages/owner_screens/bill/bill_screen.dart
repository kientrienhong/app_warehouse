import 'package:appwarehouse/common/custom_button.dart';
import 'package:appwarehouse/models/entity/order_customer.dart';
import 'package:appwarehouse/models/entity/user.dart';
import 'package:appwarehouse/pages/owner_screens/bill/detail_bill_screen.dart';
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
  TextEditingController _searchController;
  Widget _buildBillWidget(
      {@required OrderCustomer data,
      @required BuildContext context,
      @required Size deviceSize}) {
    DateFormat dateFormater = DateFormat('yyyy-MM-dd');

    Color colorStatus;
    String status;
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
                builder: (_) => DetailBillScreen(
                      data: data,
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
                            ],
                          ),
                        ])),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                      height: 8,
                    ),
                    Container(
                      width: deviceSize.width / 2.8,
                      child: CustomText(
                          text: 'Expired date: ' +
                              DateFormat('dd/MM/yyyy').format(dateFormater
                                  .parse(data.expiredDate.split('T')[0])),
                          color: CustomColor.black,
                          context: context,
                          maxLines: 2,
                          textAlign: TextAlign.right,
                          fontSize: 14),
                    ),
                    CustomSizedBox(
                      context: context,
                      height: 8,
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
    _searchController = TextEditingController();
    presenter = BillPresenter();
    presenter.view = this;
    presenter.model.pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
  }

  @override
  void onClickSearch(String id) {
    User user = Provider.of<User>(context, listen: false);
    presenter.searchBill(id, user.jwtToken);
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  void updateLoading() {
    setState(() {
      presenter.model.isLoading = !presenter.model.isLoading;
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

  Widget buildList(Size deviceSize) {
    return presenter.model.pagingController.error == null
        ? Container(
            height: deviceSize.height / 1.3,
            child: RefreshIndicator(
              onRefresh: () =>
                  Future.sync(() => presenter.model.pagingController.refresh()),
              child: PagedListView<int, OrderCustomer>(
                shrinkWrap: true,
                pagingController: presenter.model.pagingController,
                builderDelegate: PagedChildBuilderDelegate<OrderCustomer>(
                    itemBuilder: (context, item, index) => _buildBillWidget(
                        data: item, context: context, deviceSize: deviceSize)),
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
          ]);
  }

  Widget buildSearch(Size deviceSize) {
    if (presenter.model.order == null) {
      return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        CustomSizedBox(
          context: context,
          height: 8,
        ),
        CustomText(
            text: 'Not found!',
            color: CustomColor.black[3],
            context: context,
            fontSize: 24),
      ]);
    } else {
      return _buildBillWidget(
          data: presenter.model.order,
          context: context,
          deviceSize: deviceSize);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(children: [
          CustomSizedBox(
            context: context,
            height: 16,
          ),
          Row(
            children: [
              Container(
                width: deviceSize.width - 48,
                height: 40,
                child: TextFormField(
                  controller: _searchController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (String value) {
                    if (value.isEmpty) {
                      setState(() {
                        presenter.model.isSearch = false;
                        presenter.model.isLoading = false;
                        presenter.model.order = null;
                      });
                    } else {
                      onClickSearch(_searchController.text);
                    }
                  },
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () => onClickSearch(_searchController.text),
                        child: ImageIcon(
                          AssetImage('assets/images/search.png'),
                          color: CustomColor.black,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: CustomColor.black[2]))),
                ),
              )
            ],
          ),
          if (presenter.model.isSearch == false) buildList(deviceSize),
          if (presenter.model.isSearch == true) buildSearch(deviceSize),
          CustomSizedBox(
            context: context,
            height: 32,
          )
        ]),
      ),
    );
  }
}
