import 'package:appwarehouse/api/api_services.dart';
import 'package:appwarehouse/models/feedback_model.dart';
import 'package:appwarehouse/views/feedback_view.dart';

class FeedbackPresenter {
  FeedbackModel _model;
  FeedbackView _view;
  get model => this._model;

  get view => this._view;

  set view(value) => this._view = value;

  FeedbackPresenter() {
    _model = FeedbackModel();
  }

  void onHandleClickFeed(int idStorage, int idOrder, String comment,
      double rating, String jwt) async {
    try {
      _view.updateLoading();
      var response = await ApiServices.postFeedback(
          idStorage, jwt, idOrder, rating, comment);
      if (response.data['error'] == null) {
        _view.updateMsg('Feedback successful!', false);
      } else {
        _view.updateMsg('Feedback failed', true);
      }
    } catch (e) {
      print(e.toString());
      _view.updateMsg('Feedback failed', true);
    } finally {
      _view.updateLoading();
    }
  }
}
