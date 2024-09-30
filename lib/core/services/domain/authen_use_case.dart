import 'package:reading_app/core/data/prefs/prefs.dart';
import 'package:reading_app/core/services/models/authentication_model.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';

class AuthUseCase {
  static final Prefs prefs = Prefs();
  static final GetuserUseCase getuserUseCase = GetuserUseCase(prefs);

  // Method to retrieve the authentication token
  static Future<String> getAuthToken() async {
    try {
      final AuthenticationModel? authenticationModel =
          await getuserUseCase.getToken();
      if (authenticationModel != null) {
        return authenticationModel.metadata;
      }
    } catch (e) {
      return "";
    }
    return "";
  }

  // Method to check if user is logged in
  static Future<bool> isLogin() async {
    try {
      final token = await getAuthToken();
      return token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
