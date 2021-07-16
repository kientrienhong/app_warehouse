import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '/models/entity/storage.dart';
import '/models/entity/user.dart';
import '/pages/owner_screens/detail_storage/status_shelf.dart';
import '/presenters/owner_detail_storage_presenter.dart';
import '/views/owner_detail_storage_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '/common/custom_app_bar.dart';
import '/common/custom_color.dart';
import '/common/custom_sizebox.dart';
import '/common/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OwnerDetailStorage extends StatefulWidget {
  final Storage data;

  OwnerDetailStorage({this.data});

  @override
  _OwnerDetailStorageState createState() => _OwnerDetailStorageState();
}

class _OwnerDetailStorageState extends State<OwnerDetailStorage>
    implements OwnerDetailStorageView {
  OwnerDetailStoragePresenter presenter;
  @override
  void initState() {
    super.initState();
    presenter = OwnerDetailStoragePresenter();
    presenter.view = this;
    presenter.model.pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    presenter.model.pagingFeedbackController.addPageRequestListener((pageKey) {
      fetchFeedBack(pageKey);
    });
  }

  List<Widget> _buildListImageWidget(
      List<dynamic> listImages, Size deviceSize) {
    return listImages.where((element) => element['type'] == 0).map((element) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: deviceSize.width,
          height: deviceSize.height / 4.8,
          child: Image.network(element['imageUrl'], fit: BoxFit.cover),
        ),
      );
    }).toList();
  }

  @override
  void onHandleAddShelf(int idStorage) async {
    User user = Provider.of<User>(context, listen: false);
    var result = await presenter.addShelf(user.jwtToken, idStorage);
    if (result == true) {
      presenter.model.pagingController.refresh();
    }
  }

  @override
  void fetchFeedBack(int pageKey) {
    User user = Provider.of<User>(context, listen: false);
    presenter.loadListFeedBack(pageKey, 10, user.jwtToken, widget.data.id);
  }

  @override
  Future<bool> onHandleDeleteShelf(int idShelf) async {
    User user = Provider.of<User>(context, listen: false);
    var result = await presenter.deleteShelf(user.jwtToken, idShelf);
    if (result == true) {
      Navigator.of(context).pop();
      presenter.model.pagingController.refresh();
    }

    return result;
  }

  @override
  void updateLoadingAddShelf() {
    setState(() {
      presenter.model.isLoadingAddShelf = !presenter.model.isLoadingAddShelf;
    });
  }

  @override
  void updateLoadingDeleteShelf() {
    setState(() {
      presenter.model.isLoadingDeleteShelf =
          !presenter.model.isLoadingDeleteShelf;
    });
  }

  @override
  fetchPage(int pageKey) {
    User user = Provider.of<User>(context, listen: false);
    presenter.loadListShelves(pageKey, 10, user.jwtToken, widget.data.id);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColor.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            CustomAppBar(
              isHome: false,
              name: widget.data.name,
            ),
            CustomText(
                text: widget.data.name,
                color: CustomColor.black,
                context: context,
                maxLines: 2,
                fontWeight: FontWeight.bold,
                fontSize: 24),
            CustomSizedBox(
              context: context,
              height: 8,
            ),
            CarouselSlider(
                items: _buildListImageWidget(widget.data.picture, deviceSize),
                options: CarouselOptions(
                  height: deviceSize.height / 4.8,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  reverse: false,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                )),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              CustomText(
                color: CustomColor.black,
                context: context,
                fontSize: 24,
                text: 'Shelves',
                fontWeight: FontWeight.bold,
              ),
              presenter.model.isLoadingAddShelf == false
                  ? GestureDetector(
                      onTap: () => onHandleAddShelf(widget.data.id),
                      child: Container(
                        width: 24,
                        height: 24,
                        child: ImageIcon(
                          AssetImage(
                            'assets/images/plus.png',
                          ),
                          color: CustomColor.purple,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(CustomColor.purple),
                      ),
                    )
            ]),
            CustomSizedBox(
              context: context,
              height: 8,
            ),
            Container(
              height: deviceSize.height / 4,
              child: RefreshIndicator(
                onRefresh: () => Future.sync(
                    () => presenter.model.pagingController.refresh()),
                child: PagedListView<int, dynamic>(
                  shrinkWrap: true,
                  pagingController: presenter.model.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<dynamic>(
                      itemBuilder: (context, item, index) => StatusShelf(
                            isImported: false,
                            data: item,
                            isMove: false,
                            deviceSize: deviceSize,
                            presenter: presenter,
                          )),
                ),
              ),
            ),
            CustomSizedBox(
              context: context,
              height: 24,
            ),
            CustomText(
                text: 'Feedbacks',
                color: CustomColor.black,
                context: context,
                fontWeight: FontWeight.bold,
                fontSize: 24),
            CustomSizedBox(
              context: context,
              height: 16,
            ),
            Container(
              height: deviceSize.height / 3.5,
              child: PagedListView<int, dynamic>(
                shrinkWrap: true,
                pagingController: presenter.model.pagingFeedbackController,
                builderDelegate: PagedChildBuilderDelegate<dynamic>(
                    itemBuilder: (context, item, index) => FeedBackWidget(
                          data: item,
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedBackWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  FeedBackWidget({this.data});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: deviceSize.height / 6,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: CustomColor.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 14,
                offset: Offset(0, 6),
                color: Color(0xFF000000).withOpacity(0.06))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 48,
            width: deviceSize.width / 2.2,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    height: 48,
                    width: 48,
                    child: Image(
                      image: NetworkImage(data['avatar']),
                      fit: BoxFit.cover,
                      key: ValueKey(new Random().nextInt(100)),
                    ),
                  ),
                ),
                CustomSizedBox(
                  context: context,
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                        text: data['name'],
                        color: CustomColor.black,
                        context: context,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    CustomSizedBox(context: context, height: 4),
                    CustomText(
                        text: data['comment'],
                        color: CustomColor.black[3],
                        context: context,
                        fontSize: 16)
                  ],
                )
              ],
            ),
          ),
          RatingBarIndicator(
            rating: data['rating'] == null ? 0 * 1.0 : data['rating'] * 1.0,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Color(0xFFFFCC1F),
            ),
            itemCount: 5,
            itemSize: 18,
            direction: Axis.horizontal,
          ),
        ],
      ),
    );
  }
}
