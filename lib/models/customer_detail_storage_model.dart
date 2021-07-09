class CustomerDetailStorageModel {
  Map<String, int> _quantities;
  double _totalPrice;
  double _priceFrom;
  double _priceTo;
  bool _isLoading;
  bool _isError;
  String _datePickUp;

  get datePickUp => this._datePickUp;

  set datePickUp(value) => this._datePickUp = value;

  String _msg;

  bool get isError => this._isError;

  set isError(bool value) => this._isError = value;

  get msg => this._msg;

  set msg(value) => this._msg = value;

  get isLoading => this._isLoading;

  set isLoading(value) => this._isLoading = value;

  get priceFrom => this._priceFrom;

  get priceTo => this._priceTo;

  get quantities => this._quantities;

  set quantities(value) => this._quantities = value;

  get totalPrice => this._totalPrice;

  set totalPrice(value) => this._totalPrice = value;

  CustomerDetailStorageModel(double priceFrom, double priceTo) {
    this._priceFrom = priceFrom;
    this._priceTo = priceTo;
    _quantities = {
      'months': 1,
      'amountBigBox': 0,
      'amountSmallBox': 0,
    };
    _totalPrice = 0.0;
    _isLoading = false;
    _msg = '';
    _isError = false;
    _datePickUp = 'Not Yet';
  }
}
