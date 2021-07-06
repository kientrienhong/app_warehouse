import '/models/entity/shelf.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class OwnerDetailStorageModel {
  PagingController<int, dynamic> _pagingController;
  PagingController<int, dynamic> _pagingFeedbackController;

  get pagingFeedbackController => this._pagingFeedbackController;

  set pagingFeedbackController(value) => this._pagingFeedbackController = value;

  get pagingController => this._pagingController;

  set pagingController(value) => this._pagingController = value;
  bool _isLoadingAddShelf;

  bool _isLoadingDeleteShelf;
  get isLoadingAddShelf => this._isLoadingAddShelf;

  set isLoadingAddShelf(value) => this._isLoadingAddShelf = value;

  get isLoadingDeleteShelf => this._isLoadingDeleteShelf;

  set isLoadingDeleteShelf(value) => this._isLoadingDeleteShelf = value;

  OwnerDetailStorageModel() {
    _isLoadingAddShelf = false;
    _isLoadingDeleteShelf = false;
    pagingController = PagingController(firstPageKey: 0);
    _pagingFeedbackController = PagingController(firstPageKey: 0);
  }
}
