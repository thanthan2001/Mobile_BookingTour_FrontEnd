import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/data/prefs/prefs.dart';
import 'package:reading_app/core/services/api_service.dart';
import 'package:reading_app/core/services/models/authentication_model.dart';
import 'package:reading_app/core/services/models/infor_model.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';

class PersonalInfoController extends GetxController {
  // Các biến trạng thái của form
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var birthDateController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Prefs _prefs = Prefs();
  final GetuserUseCase _getuserUseCase;

  // Biến lưu thông tin ban đầu
  var initialFullName = '';
  var initialEmail = '';
  var initialPhoneNumber = '';

  // Biến lưu trạng thái thay đổi
  var fullnameChanged = false.obs;
  var emailChanged = false.obs;
  var phoneNumberChanged = false.obs;

  var user = Rx<InforModel?>(null);
  var formKey = GlobalKey<FormState>(); // Key để kiểm tra validate

  var dataEdit = {
    "PASSWORD": "", // Mật khẩu là trường bắt buộc
  };

  PersonalInfoController(this._getuserUseCase);

  @override
  void onInit() async {
    super.onInit();
    await loadUserInfo();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  // Hàm validate
  bool validateForm() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save(); // Lưu thông tin sau khi hợp lệ
      return true;
    }
    return false;
  }

  // Hàm thiết lập lắng nghe sự thay đổi
  void _setupChangeListeners() {
    fullNameController.addListener(() {
      fullnameChanged.value = fullNameController.text != initialFullName;
    });

    emailController.addListener(() {
      emailChanged.value = emailController.text != initialEmail;
    });

    phoneNumberController.addListener(() {
      phoneNumberChanged.value =
          phoneNumberController.text != initialPhoneNumber;
    });
  }

  // Hàm lưu thông tin
  Future<void> savePersonalInfo() async {
    _setupChangeListeners();
    if (validateForm()) {
      // Khởi tạo lại `dataEdit`
      dataEdit = {
        "PASSWORD": passwordController.text, // Mật khẩu là bắt buộc
      };

      // Kiểm tra các trường thay đổi
      if (fullnameChanged.value) {
        dataEdit["FULLNAME"] = fullNameController.text;
      }
      if (emailChanged.value) {
        dataEdit["EMAIL"] = emailController.text;
      }
      if (phoneNumberChanged.value) {
        dataEdit["PHONE_NUMBER"] = phoneNumberController.text;
      }

      // Kiểm tra nếu có sự thay đổi hoặc mật khẩu không rỗng
      if (dataEdit.length > 1) {
        print('Thông tin thay đổi, gọi API update...');
        print('Data edit: $dataEdit');

        // Thêm logic gọi API cập nhật thông tin ở
        final AuthenticationModel? authModel = await _getuserUseCase.getToken();

        if (authModel == null || authModel.metadata.isEmpty) {
          print("Error: Token is missing");
          return;
        }
        final String token = authModel.metadata;

        // Khởi tạo ApiService với token lấy được
        final apiService = ApiService("http://10.0.2.2:3000", token);
        final String endpoint = "/users/editUser";
        final data = dataEdit;
        try {
          final response = await apiService.postData(endpoint, data);
          if (response["success"] == true) {
            Get.snackbar("Thông báo", "Cập nhật thông tin thành công");
          }
        } catch (e) {
          print(e);
        }
      } else {
        // Không cần gọi API vì không có sự thay đổi
        print('Không có sự thay đổi, không cần gọi API.');
      }
    } else {
      print("Form is not valid");
    }
  }

  Future<void> loadUserInfo() async {
    user.value =
        await _getuserUseCase.getInfo(); // Cập nhật giá trị cho user.value
    if (user.value != null) {
      fullNameController.text = user.value!.displayName ?? '';
      emailController.text = user.value!.email ?? '';
      phoneNumberController.text = user.value!.phoneNumber ?? '';

      // Lưu lại giá trị ban đầu
      initialFullName = user.value!.displayName ?? '';
      initialEmail = user.value!.email ?? '';
      initialPhoneNumber = user.value!.phoneNumber ?? '';
    } else {
      print("No user info found");
    }
  }
}
