abstract class FeedbackView {
  void updateLoading();
  void updateMsg(String msg, bool isError);
  void handleOnClickFeedback(
      int idStorage, int idOrder, String comment, double rating);
}
