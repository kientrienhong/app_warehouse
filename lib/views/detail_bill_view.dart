abstract class DetailBillView {
  void updateLoading();
  void handleOnClickWithReason(String msg, bool isError, bool isLoading);
  void handleOnClickWithoutReason();

  void updateMsg(String msg, bool isError);
}
