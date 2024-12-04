import 'package:get/get.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:reading_app/features/nav/list_tour/presentation/controller/list_tour_controller.dart';

class ListTourBinding extends Bindings {
  @override
  void dependencies() {
    print("ListTourBinding dependencies called"); // Thêm log kiểm tra
    Get.lazyPut<GetuserUseCase>(() => GetuserUseCase(Get.find()));
    // Get.lazyPut(() => ListTourController(Get.find()));
    Get.put<ListTourController>(ListTourController(Get.find()));
  }
}
