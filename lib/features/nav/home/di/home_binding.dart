import 'package:get/get.dart';
import 'package:reading_app/core/data/prefs/prefs.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:reading_app/features/auth/user/domain/use_case/save_user_use_case.dart';
import 'package:reading_app/features/main/presentation/controller/main_controller.dart';
import 'package:reading_app/features/nav/home/presentation/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Prefs(), fenix: true); // Khởi tạo Prefs
    Get.lazyPut(() =>
        HomeController(Get.find(), Get.find())); // Khởi tạo HomeController
    Get.lazyPut(() => GetuserUseCase(Get.find()));
    Get.lazyPut(() => SaveUserUseCase(Get.find())); // Khởi tạo HomeController
  }
}
