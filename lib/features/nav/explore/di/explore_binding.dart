import 'package:get/get.dart';
import 'package:reading_app/core/data/prefs/prefs.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:reading_app/features/nav/explore/presentation/controller/explore_controller.dart';

class ExploreBinding extends Bindings {
  @override
  void dependencies() {
    // Đảm bảo rằng GetuserUseCase được khởi tạo trước khi ExploreController sử dụng nó
    Get.lazyPut(() => GetuserUseCase(Get.find()));
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut(() => ExploreController(Get.find()));
  }
}
