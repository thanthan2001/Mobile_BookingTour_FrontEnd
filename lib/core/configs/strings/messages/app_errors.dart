class AppErrors {
  static const String errorEmpty = "không được để trống ";
  static const String emailAlready =
      "Registration failed, Email may have already been used !";
  static const String formatEmail = "Sai định dạng Email";
  static const String checkMatch = "Mật khẩu không trùng khớp";
  static const String loginFail = "Tài khoản hoặc mật khẩu không chính xác !!!";
  static String minLength({required int minLength}) {
    return "Must not be less than $minLength characters";
  }

  static String maxLength({required int maxLength}) {
    return "No more than $maxLength characters";
  }

  static const String verifyFail = "Failed to send verification email.";
  static const String noUerLogin = "No user logged in.";
}
