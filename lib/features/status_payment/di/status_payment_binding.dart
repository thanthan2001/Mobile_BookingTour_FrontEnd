import 'package:get/get.dart';
import 'package:reading_app/features/status_payment/presentation/controller/status_payment_controller.dart';

class StatusPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatusPaymentController());
  }
}
