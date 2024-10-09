import 'package:get/get.dart';
import 'package:reading_app/features/detail_tour/presentation/controller/detail_tour_controller.dart';

class DetailTourBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailTourController>(() => DetailTourController(Get.find()));
  }
}
