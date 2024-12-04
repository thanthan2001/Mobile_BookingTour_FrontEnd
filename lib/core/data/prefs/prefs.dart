import 'dart:convert';

import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/data/firebase/model/user_model.dart';
import 'package:reading_app/core/services/models/infor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  // Initial shared preferences /
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static final Prefs preferences = Prefs();

  // Initial method String /
  Future<String> get(String key) async {
    final SharedPreferences prefs = await _prefs;
    return json.decode(prefs.getString(key)!) ?? '';
  }

  Future<String> getObject(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key) ?? '';
  }

  Future<bool?> getBool(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(key);
  }

  Future<int> getInt(String key) async {
    final SharedPreferences prefs = await _prefs;
    final int? value = prefs.getInt(key); // Lấy giá trị và gán vào biến value
    // Kiểm tra nếu value là null thì trả về 0, ngược lại trả về giá trị value
    return value ?? 0;
  }

  Future set(String key, dynamic value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, json.encode(value));
  }

  Future setBool(String key, value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(key, value);
  }

  Future setInt(String key, value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt(key, value);
  }

  Future remove(String key) async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(key);
  }

  Future clear() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }

  Future logout() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(PrefsConstants.user);
  }

  Future setTempUser(UserModel? value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(PrefsConstants.tmpUid, json.encode(value));
  }

  Future setTempUser2(InforModel? value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(PrefsConstants.tmpUid, json.encode(value));
  }

  Future<String?> getString(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs
        .getString(key); // Return the raw string stored under the given key
  }

  Future<UserModel?> getTempUser() async {
    final SharedPreferences prefs = await _prefs;
    final tempUserJson = prefs.getString(PrefsConstants.tmpUid);
    if (tempUserJson == null || tempUserJson.isEmpty) {
      return null;
    }
    return UserModel.fromJson(json.decode(tempUserJson));
  }

  Future<InforModel?> getTempUser2() async {
    final SharedPreferences prefs = await _prefs;
    final tempUserJson = prefs.getString(PrefsConstants.tmpUid);
    if (tempUserJson == null || tempUserJson.isEmpty) {
      return null;
    }
    return InforModel.fromJson(json.decode(tempUserJson));
  }
}
