abstract class SignUpView {
  void updateLoading();

  void updateMsg(String msg, bool isError);

  void onClickSignUp(String email, String password, String name, String address,
      String phone, String confirmPassword, String role);
}
