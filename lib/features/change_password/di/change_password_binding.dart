import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:reading_app/features/change_password/presentation/controller/change_password_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => GetuserUseCase(Get.find()));
    Get.lazyPut(() => ChangePasswordController(Get.find()));
  }
}
