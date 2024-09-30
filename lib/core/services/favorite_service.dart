import 'dart:convert';

import 'package:get/get.dart';
import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/data/prefs/prefs.dart';

class FavoriteService extends GetxService {
  final Prefs prefs;

  FavoriteService(this.prefs);

  void saveFavoriteCase() {
    List<String> listPostFavorite = ["id1", "id2", "id3"];
    try {
      var result = prefs.get(PrefsConstants.favorite);
      print(result);
    } catch (e) {
      prefs.set(PrefsConstants.favorite, jsonEncode(listPostFavorite));
    }
  }
}
