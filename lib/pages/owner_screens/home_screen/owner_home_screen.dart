import '/common/custom_button.dart';
import '/common/custom_color.dart';
import '/common/custom_text.dart';

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
  bool isForceReload;
  OwnerHomeScreen({@required this.isForceReload});

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
    await presenter.loadList(pageKey, 5, user.jwtToken);
  }

  @override
  void onClickSearch(int pageKey, String search) {}

  @override
  void updateSearch() {
    setState(() {});
  }

  @override
  void updateLoadingDeleteStorage() {
    setState(() {
      presenter.model.isLoadingDeleteStorage =
          !presenter.model.isLoadingDeleteStorage;
    });
  }

  @override
  void updateLoadingRefresh() {
    setState(() {
      presenter.model.isLoadingRefresh = !presenter.model.isLoadingRefresh;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    if (widget.isForceReload == true) {
      presenter.model.pagingController.refresh();
      widget.isForceReload = false;
    }

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
                  height: deviceSize.height / 1.2,
                  padding: EdgeInsets.only(bottom: deviceSize.height / 10),
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
                          isLoading: presenter.model.isLoadingRefresh,
                          textColor: CustomColor.white,
                          onPressFunction: () async {
                            try {
                              presenter.view.updateLoadingRefresh();
                              await fetchPage(0, '');
                            } catch (e) {
                              print(e.toString());
                            } finally {
                              presenter.view.updateLoadingRefresh();
                            }
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
