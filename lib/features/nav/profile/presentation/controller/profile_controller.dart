import 'package:get/get.dart';
import 'package:reading_app/core/data/prefs/prefs.dart';

class ProfileController extends GetxController {
  final Prefs _prefs = Prefs();

  Future<void> logout() async {
    await _prefs.clear();
    Get.offAllNamed('/login');
  }
}
