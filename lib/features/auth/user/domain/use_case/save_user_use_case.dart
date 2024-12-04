import 'dart:convert';

import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/data/firebase/model/user_model.dart';
import 'package:reading_app/core/data/prefs/prefs.dart';
import 'package:reading_app/core/services/models/authentication_model.dart';
import 'package:reading_app/core/services/models/infor_model.dart';

class SaveUserUseCase {
  final Prefs _prefs;

  SaveUserUseCase(this._prefs);

  Future<void> saveUser(UserModel? user) async {
    if (user != null) {
      try {
        final userJson = jsonEncode(user.toJson());
        await _prefs.set(PrefsConstants.user, userJson);
      } catch (e) {
        // Handle the error, maybe log it or show an alert
        print('Failed to save user: $e');
      }
    }
  }

  Future<void> saveInfo(InforModel? user) async {
    if (user != null) {
      try {
        final userJson = jsonEncode(user.toJson());
        await _prefs.setTempUser2(user);
      } catch (e) {
        print('Failed to save user: $e');
      }
    }
  }

  Future<void> saveToken(AuthenticationModel model) async {
    try {
      final authentication = jsonEncode(model.toJson());
      await _prefs.set(PrefsConstants.userToken, authentication);
    } catch (e) {
      // Handle the error, maybe log it or show an alert
      print('Failed to save user: $e');
    }
  }
}
