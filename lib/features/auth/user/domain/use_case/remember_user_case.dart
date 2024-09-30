import 'dart:convert';

import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/data/firebase/model/user_model.dart';
import 'package:reading_app/core/data/prefs/prefs.dart';

class RememberUserCase {
  final Prefs _prefs;
  RememberUserCase(this._prefs);
  Future<void> set(UserModel? user) async {
    if (user != null) {
      try {
        final userJson = jsonEncode(user.toJson());
        await _prefs.set(PrefsConstants.rememberAccount, userJson);
      } catch (e) {
        print('Failed to save user: $e');
      }
    }
  }
  
  Future<UserModel?> get() async {
    try {
      final String tokenJson = await _prefs.get(PrefsConstants.rememberAccount);
      if (tokenJson.isEmpty) {
        return null;
      }
      final Map<String, dynamic> userMap = jsonDecode(tokenJson);
      return UserModel.fromJson(userMap);
    } catch (e) {
      print('Failed to get user: $e');
      return null;
    }
  }
}
