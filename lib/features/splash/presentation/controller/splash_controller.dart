import 'package:get/get.dart';
import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/data/firebase/firebae_auth/firebase_auth.dart';
import 'package:reading_app/core/data/prefs/prefs.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';

class SplashController extends GetxController {
  final Prefs prefs;
  final GetuserUseCase _getuserUseCase;
  SplashController(this._getuserUseCase, this.prefs);
  RxDouble loadingProgress = 0.0.obs;

  @override
  void onInit() {
    simulateLoading();
    super.onInit();
  }

  Future<void> simulateLoading() async {
    // Xóa tài khoản vừa đăng ký thất bại
    try {
      dynamic idAccountwaitingVerify =
          await prefs.get(PrefsConstants.idAccountwaitingVerify);
      await FirebaseAuthentication.deleteUserAccount(idAccountwaitingVerify);
    } catch (e) {
      print(e);
    }

    prefs.logout();

    _getuserUseCase.getToken().then(
      (value) {
        if (value != null) {
          Get.offNamed(Routes.main);
        } else {
          Get.offNamed(Routes.login);
        }
      },
    );
  }
}
