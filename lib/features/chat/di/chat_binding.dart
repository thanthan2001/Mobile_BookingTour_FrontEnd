import 'package:get/get.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';
import 'package:reading_app/features/chat/presentation/controller/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController(Get.find()));
    Get.lazyPut(() => GetuserUseCase(Get.find()));
  }
}
