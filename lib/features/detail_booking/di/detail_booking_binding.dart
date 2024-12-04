import 'package:get/get.dart';
import 'package:reading_app/features/detail_booking/presentation/controller/detail_booking_controller.dart';

class DetailBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailBookingController(Get.find()));
  }
}
