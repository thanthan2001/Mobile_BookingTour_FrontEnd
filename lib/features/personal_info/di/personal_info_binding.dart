import 'package:get/get.dart';
import 'package:reading_app/features/personal_info/presentation/controller/personal_info_controller.dart';

class PersonalInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PersonalInfoController());
  }
}
