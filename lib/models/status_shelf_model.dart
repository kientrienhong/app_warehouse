class StatusShelfModel {
  bool _isLoading;
  get isLoading => this._isLoading;

  set isLoading(value) => this._isLoading = value;

  StatusShelfModel() {
    _isLoading = false;
  }
}
