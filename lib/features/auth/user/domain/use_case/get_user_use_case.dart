import 'dart:convert';

import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/data/prefs/prefs.dart';
import 'package:reading_app/core/services/models/authentication_model.dart';
import 'package:reading_app/features/auth/user/model/user_model.dart';

class GetuserUseCase {
  final Prefs _prefs;

  GetuserUseCase(this._prefs);

  Future<UserModel?> getUser() async {
    try {
      // Retrieve JSON string from Prefs
      final String? tokenJson = await _prefs.get(PrefsConstants.user);

      if (tokenJson == null || tokenJson.isEmpty) {
        return null;
      }
      // Decode JSON string to Map
      final Map<String, dynamic> userMap = jsonDecode(tokenJson);

      // Convert Map to UserModel
      return UserModel.fromJson(userMap);
    } catch (e) {
      // Handle any errors during decoding or mapping
      print('Failed to get user: $e');
      return null;
    }
  }

  Future<AuthenticationModel?> getToken() async {
    try {
      // Retrieve JSON string from Prefs
      final String? tokenJson = await _prefs.get(PrefsConstants.userToken);

      if (tokenJson == null || tokenJson.isEmpty) {
        return null;
      }

      // Decode JSON string to Map
      final Map<String, dynamic> authMap = jsonDecode(tokenJson);

      // Convert Map to UserModel
      return AuthenticationModel.fromJson(authMap);
    } catch (e) {
      // Handle any errors during decoding or mapping
      print('Failed to get user: $e');
      return null;
    }
  }

  // Hàm giải mã AccessToken để lấy thông tin user
  Map<String, dynamic>? decodeAccessToken(String accessToken) {
    try {
      // Tách token thành 3 phần: header, payload, signature
      final parts = accessToken.split('.');
      if (parts.length != 3) {
        throw Exception('Invalid Access Token');
      }

      // Phần payload là phần thứ hai, được encode bằng Base64URL
      final payload = parts[1];

      // Giải mã payload từ Base64URL
      final normalized = base64Url.normalize(payload);
      final decodedPayload = utf8.decode(base64Url.decode(normalized));

      // Chuyển payload từ JSON thành Map
      final payloadMap = jsonDecode(decodedPayload) as Map<String, dynamic>;

      return payloadMap;
    } catch (e) {
      print('Failed to decode access token: $e');
      return null;
    }
  }
}
