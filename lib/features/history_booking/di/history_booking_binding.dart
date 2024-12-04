import 'package:get/get.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:reading_app/features/history_booking/presentation/controller/history_booking_controller.dart';

class HistoryBookingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GetuserUseCase(Get.find()));
    Get.lazyPut(() => HistoryBookingController(Get.find()));
  }
}
