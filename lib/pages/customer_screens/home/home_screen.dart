import 'package:app_warehouse/api/api_services.dart';
import 'package:app_warehouse/common/custom_app_bar.dart';
import 'package:app_warehouse/common/custom_color.dart';
import 'package:app_warehouse/common/custom_sizebox.dart';
import 'package:app_warehouse/models/entity/storage.dart';
import 'package:app_warehouse/models/entity/user.dart';
import 'package:app_warehouse/pages/customer_screens/home/storage_procteting_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CustomerHomeScreen extends StatefulWidget {
  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  static const _pageSize = 10;

  final PagingController<int, Storage> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      User user = Provider.of<User>(context, listen: false);
      final response =
          await ApiServices.loadListStorage(pageKey, _pageSize, user.jwtToken);
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
                  decoration: InputDecoration(
                      prefixIcon: ImageIcon(
                        AssetImage('assets/images/search.png'),
                        color: CustomColor.black,
                      ),
                      suffixIcon: ImageIcon(
                        AssetImage('assets/images/filter.png'),
                        color: CustomColor.black,
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
          Container(
            height: deviceSize.height / 1.5,
            child: PagedListView<int, Storage>(
              shrinkWrap: true,
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Storage>(
                  itemBuilder: (context, item, index) =>
                      StorageProtectingWidget(
                          data: item, deviceSize: deviceSize)),
            ),
          ),
          CustomSizedBox(
            context: context,
            height: 72,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
