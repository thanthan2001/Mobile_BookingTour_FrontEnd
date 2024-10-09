import 'package:get/get.dart';

import '../presentation/controller/vnpay_controller.dart';

class VNPayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VNPayController());
  }
}
