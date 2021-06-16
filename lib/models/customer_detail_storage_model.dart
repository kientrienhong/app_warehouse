class CustomerDetailStorageModel {
  Map<String, int> _quantities;
  double _totalPrice;
  double _priceFrom;
  double _priceTo;
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
  }
}
