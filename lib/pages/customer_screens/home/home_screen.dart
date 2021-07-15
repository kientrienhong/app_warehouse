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
  void onClickSearch(int pageKey, String search) {
    User user = Provider.of<User>(context, listen: false);
    presenter.onClickSearch(pageKey, search, user.jwtToken, _pageSize,
        presenter.model.isPrice, presenter.model.isRating);
  }

  @override
  void updateSearch() async {
    _pagingController.refresh();
  }

  @override
  void onClickChangeDropDown(String value) {
    setState(() {
      presenter.model.typeOfSort = value;
    });

    switch (value) {
      case 'Sort':
        {
          presenter.model.isPrice = null;
          presenter.model.isRating = null;
          break;
        }
      case 'Ascending Price':
        {
          presenter.model.isPrice = true;
          presenter.model.isRating = null;
          break;
        }
      case 'Descending Price':
        {
          presenter.model.isPrice = false;
          presenter.model.isRating = null;
          break;
        }
      case 'Ascending Rating':
        {
          presenter.model.isPrice = null;
          presenter.model.isRating = false;
          break;
        }
      default:
        {
          presenter.model.isPrice = null;
          presenter.model.isRating = true;
          break;
        }
    }
    onClickSearch(0, _searchController.text);
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
          pageKey,
          _pageSize,
          user.jwtToken,
          presenter.model.searchAddress,
          presenter.model.isPrice,
          presenter.model.isRating);
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: deviceSize.width / 1.5 - 48,
                height: 40,
                child: TextFormField(
                  controller: _searchController,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (String value) {
                    onClickSearch(0, _searchController.text);
                  },
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () => onClickSearch(0, _searchController.text),
                        child: ImageIcon(
                          AssetImage('assets/images/search.png'),
                          color: CustomColor.black,
                        ),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: CustomColor.black[2]))),
                ),
              ),
              Container(
                height: 40,
                width: 106,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    border: Border.all(color: CustomColor.black[3], width: 1),
                    borderRadius: BorderRadius.circular(8)),
                child: DropdownButton(
                    // icon: ImageIcon(
                    //   AssetImage('assets/images/arrowDown.png'),
                    // ),
                    iconSize: 16,
                    underline: Container(
                      width: 0,
                    ),
                    value: presenter.model.typeOfSort,
                    onChanged: (value) {
                      onClickChangeDropDown(value);
                    },
                    items: <String>[
                      'Sort',
                      'Ascending Price',
                      'Descending Price',
                      'Ascending Rating',
                      'Descending Rating'
                    ].map((e) {
                      String imageUrl = '';
                      String content =
                          e.split(' ').length == 1 ? 'Sort' : e.split(' ')[1];
                      if (e.contains('Ascending')) {
                        imageUrl = 'assets/images/arrowUp.png';
                      } else {
                        imageUrl = 'assets/images/arrowDown.png';
                      }

                      return DropdownMenuItem<String>(
                          value: e,
                          child: Row(children: [
                            CustomText(
                                text: content,
                                color: CustomColor.black,
                                context: context,
                                fontSize: 16),
                            if (content != 'Sort')
                              Container(
                                  height: 16,
                                  width: 16,
                                  child: Image.asset(imageUrl))
                          ]));
                    }).toList()),
              ),
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
              : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CustomText(
                      text: 'Not found!',
                      color: CustomColor.black[3],
                      context: context,
                      fontSize: 24),
                ]),
          CustomSizedBox(
            context: context,
            height: 72,
          )
        ],
      ),
    );
  }
}
