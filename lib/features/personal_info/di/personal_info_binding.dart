import 'package:get/get.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:reading_app/features/personal_info/presentation/controller/personal_info_controller.dart';

class PersonalInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetuserUseCase(Get.find()));
    Get.lazyPut(() => PersonalInfoController(Get.find()));
  }
}
