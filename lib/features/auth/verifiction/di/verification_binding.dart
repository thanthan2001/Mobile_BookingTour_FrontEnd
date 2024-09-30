import 'package:get/get.dart';
import 'package:reading_app/core/data/prefs/prefs.dart';
import 'package:reading_app/features/auth/user/domain/use_case/save_user_use_case.dart';
import 'package:reading_app/features/auth/verifiction/presentation/controller/verification_controller.dart';

class VerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => SaveUserUseCase(Get.find()));
    Get.put(VerificationController(Get.find()));
  }
}
