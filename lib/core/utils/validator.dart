import 'package:reading_app/core/configs/const/enum.dart';
import 'package:reading_app/core/configs/strings/messages/app_errors.dart';

class Validators {
  Validators._();

  static bool validateEmail(String value) {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(value);
  }

  static validPassword(String password) {
    String pattern = r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,20}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }

  static String checkErrorsLength({
    required String value,
    required int minLenth,
    required maxLength,
  }) {
    if (value.trim().isEmpty) return AppErrors.errorEmpty;

    if (value.trim().length < minLenth) {
      return AppErrors.minLength(minLength: minLenth);
    }
    if (value.trim().length > maxLength) {
      return AppErrors.maxLength(maxLength: maxLength);
    }
    return "";
  }

  static String checkErrorEmail(
      {required String value, EmailErrors type = EmailErrors.format}) {
    if (!validateEmail(value.trim())) return AppErrors.formatEmail;
    if (type == EmailErrors.already) return AppErrors.emailAlready;
    return "";
  }

  static String checkMatch({required String value_1, required String value_2}) {
    if (value_1.trim() != value_2.trim()) return AppErrors.checkMatch;
    return "";
  }
}
