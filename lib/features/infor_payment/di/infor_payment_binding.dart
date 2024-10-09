import 'package:get/get.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:reading_app/features/infor_payment/presentation/controller/infor_payment_controller.dart';

class InforPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InforPaymentController(Get.find()));
  }
}
