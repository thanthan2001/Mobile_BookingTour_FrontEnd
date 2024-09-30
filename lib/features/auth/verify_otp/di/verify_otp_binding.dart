import 'package:get/get.dart';
import 'package:reading_app/features/auth/verify_otp/presentation/controller/verify_controller.dart';

class VerifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyOTPController>(() => VerifyOTPController());
  }
}
