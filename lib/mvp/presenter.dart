import 'package:app_warehouse/mvp/mvp_view.dart';

class Presenter<T extends MVPView> {
  T _view;

  attachView(T view) {
    _view = view;
  }

  dispose() {
    _view = null;
  }

  getView() {
    return _view;
  }
}
