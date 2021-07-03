import 'package:appwarehouse/common/custom_button.dart';
import 'package:appwarehouse/common/custom_color.dart';
import 'package:appwarehouse/common/custom_text.dart';

import '/api/api_services.dart';
import '/common/custom_app_bar.dart';
import '/common/custom_sizebox.dart';
import '/models/entity/user.dart';
import '/models/entity/storage.dart';
import '/pages/owner_screens/home_screen/owner_storage.dart';
import '/presenters/home_presenter.dart';
import '/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

enum StatusCheckingStorage { Pending, Approved, Reject }

class OwnerHomeScreen extends StatefulWidget {
  @override
  _OwnerHomeScreenState createState() => _OwnerHomeScreenState();
}

class _OwnerHomeScreenState extends State<OwnerHomeScreen> implements HomeView {
  HomePresenter presenter;
  @override
  void initState() {
    super.initState();
    presenter = HomePresenter();
    presenter.view = this;
    presenter.model.pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey, '');
    });
  }

  @override
  Future<void> fetchPage(int pageKey, String address) async {
    User user = Provider.of<User>(context, listen: false);
    await presenter.loadList(pageKey, 5, user.jwtToken, '');
  }

  @override
  void onClickSearch(String search) {}

  @override
  void updateSearch() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        children: [
          CustomAppBar(
            isHome: true,
          ),
          CustomSizedBox(
            context: context,
            height: 24,
          ),
          presenter.model.pagingController.error == null
              ? Container(
                  height: deviceSize.height / 1.5,
                  child: RefreshIndicator(
                    onRefresh: () => Future.sync(
                        () => presenter.model.pagingController.refresh()),
                    child: PagedListView<int, Storage>(
                      shrinkWrap: true,
                      pagingController: presenter.model.pagingController,
                      builderDelegate: PagedChildBuilderDelegate<Storage>(
                          itemBuilder: (context, item, index) => OwnerStorage(
                                data: item,
                                deviceSize: deviceSize,
                                pageController:
                                    presenter.model.pagingController,
                                presenter: presenter,
                              )),
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      CustomText(
                          text: 'Not have storage yet!',
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
                            await fetchPage(0, '');
                          },
                          buttonColor: CustomColor.purple,
                          borderRadius: 4),
                    ]),
          CustomSizedBox(
            context: context,
            height: 72,
          ),
        ],
      ),
    );
  }
}
