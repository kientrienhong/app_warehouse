abstract class ChangePasswordView {
  //update view
  updateLoading();

  updateMsg(String msg, bool isError);

  // handle event
  onHandleChangePasword(String password, String oldPassword, String confirm);
}
