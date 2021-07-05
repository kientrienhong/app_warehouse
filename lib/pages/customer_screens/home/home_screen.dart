import '/common/custom_text.dart';

import '/api/api_services.dart';
import '/common/custom_app_bar.dart';
import '/common/custom_color.dart';
import '/common/custom_sizebox.dart';
import '/models/entity/storage.dart';
import '/models/entity/user.dart';
import '/pages/customer_screens/home/storage_procteting_widget.dart';
import '/presenters/home_presenter.dart';
import '/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CustomerHomeScreen extends StatefulWidget {
  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen>
    implements HomeView {
  static const _pageSize = 10;
  HomePresenter presenter;
  PagingController<int, Storage> _pagingController =
      PagingController(firstPageKey: 0);
  TextEditingController _searchController;
  @override
  void onClickSearch(String search) {
    presenter.onClickSearch(search);
  }

  @override
  void updateSearch() async {
    _pagingController.refresh();
  }

  @override
  Future<void> fetchPage(int pageKey, String address) {}

  @override
  void updateLoadingDeleteStorage() {}
  @override
  void updateLoadingRefresh() {}

  @override
  void initState() {
    presenter = HomePresenter();
    presenter.view = this;
    _searchController = TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
    _searchController.dispose();
  }

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
          Row(
            children: [
              Container(
                width: deviceSize.width - 48,
                height: 40,
                child: TextFormField(
                  controller: _searchController,
                  textInputAction: TextInputAction.done,
                  //its about this part
                  onFieldSubmitted: (String value) {
                    onClickSearch(_searchController.text);
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
          CustomSizedBox(
            context: context,
            height: 24,
          ),
          _pagingController.error == null
              ? Container(
                  height: deviceSize.height / 1.5,
                  child: PagedListView<int, Storage>(
                    shrinkWrap: true,
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Storage>(
                        itemBuilder: (context, item, index) =>
                            StorageProtectingWidget(
                                data: item, deviceSize: deviceSize)),
                  ),
                )
              : CustomText(
                  text: 'Not found!',
                  color: CustomColor.black[3],
                  context: context,
                  fontSize: 24),
          CustomSizedBox(
            context: context,
            height: 72,
          )
        ],
      ),
    );
  }
}
