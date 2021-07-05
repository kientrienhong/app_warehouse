class FeedbackModel {
  bool _isLoading;
  String _msg;
  bool _isError;
  String get msg => this._msg;

  set msg(String value) => this._msg = value;

  get isError => this._isError;

  set isError(value) => this._isError = value;
  get isLoading => this._isLoading;

  set isLoading(value) => this._isLoading = value;

  FeedbackModel() {
    _msg = '';
    _isError = false;
    _isLoading = false;
  }
}
