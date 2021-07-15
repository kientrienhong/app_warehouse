class DetailBillScreenModel {
  bool _isLoading;
  bool _isLoadingStorage;
  get isLoadingStorage => this._isLoadingStorage;

  set isLoadingStorage(value) => this._isLoadingStorage = value;
  bool _isError;
  String _msg;
  Map<String, dynamic> _positionSmallBox;
  Map<String, dynamic> _positionLargeBox;
  bool _isAlreadyCheckOut;

  get isAlreadyCheckOut => this._isAlreadyCheckOut;

  set isAlreadyCheckOut(value) => this._isAlreadyCheckOut = value;
  get positionSmallBox => this._positionSmallBox;

  set positionSmallBox(value) => this._positionSmallBox = value;

  get positionLargeBox => this._positionLargeBox;

  set positionLargeBox(value) => this._positionLargeBox = value;

  bool get isLoading => this._isLoading;

  set isLoading(bool value) => this._isLoading = value;

  get isError => this._isError;

  set isError(value) => this._isError = value;

  get msg => this._msg;

  set msg(value) => this._msg = value;

  DetailBillScreenModel() {
    _msg = '';
    _positionLargeBox = {};
    _isLoading = false;
    _isError = false;
    _positionSmallBox = {};
    _isLoadingStorage = false;
    _isAlreadyCheckOut = false;
  }
}
