import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/const/enum.dart';
import 'package:reading_app/core/services/api_service.dart';
import 'package:reading_app/core/services/models/authentication_model.dart';
import 'package:reading_app/core/ui/dialogs/dialogs.dart';
import 'package:reading_app/features/auth/user/domain/use_case/get_user_use_case.dart';

class ChangePasswordController extends GetxController {
  final GetuserUseCase _getuserUseCase;
  ChangePasswordController(this._getuserUseCase);

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Observables for password visibility
  var isOldPasswordVisible = false.obs;
  var isNewPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  Future<void> changePassword() async {
    // Validation checks
    if (oldPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar("Error", "Vui lòng điền đầy đủ thông tin");
      return;
    }

    if (newPasswordController.text.length < 6) {
      Get.snackbar("Error", "Mật khẩu mới phải có ít nhất 6 ký tự");
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar("Error", "Mật khẩu không trùng khớp");
      return;
    }

    final AuthenticationModel? authModel = await _getuserUseCase.getToken();
    if (authModel == null || authModel.metadata.isEmpty) {
      Get.snackbar("Error", "Thiếu token để xác thực");
      return;
    }
    final String token = authModel.metadata;
    final apiService = ApiService("http://10.0.2.2:3000", token);
    final String endpoint = "/users/change-password";

    try {
      final response = await apiService.postData(endpoint, {
        "oldPassword": oldPasswordController.text,
        "newPassword": newPasswordController.text,
      });
      if (response["success"] == true) {
        print("msg change pass $response");
        clearAll();
        Get.snackbar("Success", response["message"]);
      } else {
        Get.snackbar("Error", response["message"]);
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "Đổi mật khẩu thất bại");
    }
  }

  void clearAll() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }
}
