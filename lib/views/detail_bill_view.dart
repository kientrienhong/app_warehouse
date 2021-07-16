abstract class DetailBillView {
  void updateLoading();
  void updateLoadingStorage();
  void handleOnClickWithReason(String msg, bool isError, bool isLoading);
  void handleOnClickWithoutReason();
  void handleOnClickGoToStorage();
  void updateMsg(String msg, bool isError);
}
