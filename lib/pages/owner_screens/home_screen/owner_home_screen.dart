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
  static const _pageSize = 10;
  final PagingController<int, Storage> _pagingController =
      PagingController(firstPageKey: 0);
  HomePresenter presenter;
  @override
  void initState() {
    presenter = HomePresenter();
    presenter.view = this;
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void onClickSearch(String search) {}

  @override
  void updateSearch() {}

  Future<void> _fetchPage(int pageKey) async {
    try {
      User user = Provider.of<User>(context, listen: false);
      final response = await ApiServices.loadListStorage(
          pageKey, _pageSize, user.jwtToken, presenter.model.searchAddress);
      List<dynamic> result = response.data['data'];
      List<Storage> newItems =
          result.map<Storage>((e) => Storage.fromMap(e)).toList();
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      print(error.toString());
      _pagingController.error = error;
    }
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
          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: ScrollPhysics(),
          //   itemBuilder: (_, index) {
          //     return OwnerStorage(
          //         data: mockUpData[index], deviceSize: deviceSize);
          //   },
          //   itemCount: mockUpData.length,
          // ),
          Container(
            height: deviceSize.height / 1.5,
            child: PagedListView<int, Storage>(
              shrinkWrap: true,
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Storage>(
                  itemBuilder: (context, item, index) =>
                      OwnerStorage(data: item, deviceSize: deviceSize)),
            ),
          ),
          CustomSizedBox(
            context: context,
            height: 72,
          ),
        ],
      ),
    );
  }
}
