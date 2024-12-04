import 'package:get/get.dart';
import 'package:reading_app/core/data/prefs/prefs.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:reading_app/features/detail_tour/presentation/controller/detail_tour_controller.dart';

class DetailTourBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetuserUseCase(Get.find()));
    Get.lazyPut(() => Prefs(), fenix: true);
    Get.lazyPut<DetailTourController>(() => DetailTourController(Get.find()));
  }
}
