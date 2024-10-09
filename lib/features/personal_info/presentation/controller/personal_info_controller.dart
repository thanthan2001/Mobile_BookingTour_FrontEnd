import 'package:get/get.dart';

class PersonalInfoController extends GetxController {
  // Các biến trạng thái của form
  var fullName = ''.obs;
  var email = ''.obs;
  var phoneNumber = ''.obs;
  var birthDate = ''.obs;
  var department = ''.obs;
  var city = ''.obs;
  var address = ''.obs;

  // Hàm lưu thông tin
  void savePersonalInfo() {
    // Thực hiện logic lưu thông tin
    print('Saving personal info...');
  }
}
