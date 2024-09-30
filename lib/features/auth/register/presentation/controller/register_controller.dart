import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/const/enum.dart';
import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/strings/messages/app_errors.dart';
import 'package:reading_app/core/configs/strings/messages/app_success.dart';
import 'package:reading_app/core/data/firebase/firebae_auth/firebase_auth.dart'; // Thay đổi đường dẫn nếu cần
import 'package:reading_app/core/data/firebase/model/result.dart';
import 'package:reading_app/core/data/firebase/model/user_model.dart';
import 'package:reading_app/core/data/prefs/prefs.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/services/api_service.dart';
import 'package:reading_app/core/utils/validator.dart';

class RegisterController extends GetxController {
  final Prefs prefs;

  RegisterController(this.prefs);
  // Controllers cho các trường nhập liệu
  final phoneNumber = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final OTPController = TextEditingController();
  // Trạng thái loading
  var isLoading = false.obs;

  // Các thông báo lỗi
  var errorMessageName = ''.obs;
  var errorMessageEmail = ''.obs;
  var errorMessagePassword = ''.obs;
  var errorMessagePasswordConfirm = ''.obs;

  // Phương thức đăng ký
  Future<void> signUp() async {
    // Reset thông báo lỗi
    errorMessageName.value = '';
    errorMessageEmail.value = '';
    errorMessagePassword.value = '';
    errorMessagePasswordConfirm.value = '';

    // check user name
    if (Validators.checkErrorsLength(
            value: phoneNumber.text, minLenth: 4, maxLength: 50)
        .isNotEmpty) {
      errorMessageName.value = Validators.checkErrorsLength(
          value: phoneNumber.text, minLenth: 4, maxLength: 50);
    }

    // check user name
    if (Validators.checkErrorsLength(
            value: emailController.text, minLenth: 8, maxLength: 50)
        .isNotEmpty) {
      errorMessageEmail.value = Validators.checkErrorsLength(
          value: emailController.text, minLenth: 8, maxLength: 20);
    }

    // checkpassword
    if (Validators.checkErrorsLength(
            value: passwordController.text, minLenth: 6, maxLength: 11)
        .isNotEmpty) {
      errorMessagePassword.value = Validators.checkErrorsLength(
          value: passwordController.text, minLenth: 6, maxLength: 11);
    }

    // check email format
    if (Validators.checkErrorEmail(value: emailController.text).isNotEmpty) {
      errorMessageEmail.value =
          Validators.checkErrorEmail(value: emailController.text);
    }

    //check match
    if (errorMessagePassword.value.isEmpty) {
      if (Validators.checkMatch(
              value_1: passwordController.text,
              value_2: passwordConfirmController.text)
          .isNotEmpty) {
        errorMessagePasswordConfirm.value = Validators.checkMatch(
            value_1: passwordController.text,
            value_2: passwordConfirmController.text);
      }
    }

    // Nếu có lỗi, không thực hiện đăng ký
    if (errorMessageName.value.isNotEmpty ||
        errorMessageEmail.value.isNotEmpty ||
        errorMessagePassword.value.isNotEmpty ||
        errorMessagePasswordConfirm.value.isNotEmpty) {
      return;
    }

    isLoading.value = true; // Bắt đầu loading

    // Gọi API để đăng ký
    Result<UserModel> result = await FirebaseAuthentication.signUp(
      email: emailController.text,
      password: passwordController.text,
    );

    isLoading.value = false; // Kết thúc loading

    if (result.status == Status.success) {
      await prefs.set(PrefsConstants.idAccountwaitingVerify, result.data!.uid);

      // Đăng ký thành công
      Get.snackbar(AppContents.successTag, AppSuccess.requestVerify);
      UserModel user = UserModel(
          uid: result.data!.uid,
          displayName: phoneNumber.text,
          email: emailController.text,
          password: passwordController.text,
          creationTime: DateTime.now().toString());
      // Chuyển hướng hoặc thông báo thành công

      Get.toNamed(Routes.verifyOTP, arguments: user);
    } else {
      Get.snackbar(AppContents.errorTag, AppErrors.emailAlready);
    }
  }

  @override
  void onClose() {
    // Đảm bảo các controllers được giải phóng khi controller bị hủy
    phoneNumber.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.onClose();
  }

  Future<void> register() async {
    errorMessageName.value = '';
    errorMessageEmail.value = '';
    errorMessagePassword.value = '';
    errorMessagePasswordConfirm.value = '';

    // check user name
    if (Validators.checkErrorsLength(
            value: phoneNumber.text, minLenth: 4, maxLength: 50)
        .isNotEmpty) {
      errorMessageName.value = "SDT " +
          Validators.checkErrorsLength(
              value: phoneNumber.text, minLenth: 4, maxLength: 50);
    }

    // check user name
    if (Validators.checkErrorsLength(
            value: emailController.text, minLenth: 8, maxLength: 50)
        .isNotEmpty) {
      errorMessageEmail.value = Validators.checkErrorsLength(
          value: emailController.text, minLenth: 8, maxLength: 20);
    }

    // checkpassword
    if (Validators.checkErrorsLength(
            value: passwordController.text, minLenth: 6, maxLength: 11)
        .isNotEmpty) {
      errorMessagePassword.value = Validators.checkErrorsLength(
          value: passwordController.text, minLenth: 6, maxLength: 11);
    }

    // check email format
    if (Validators.checkErrorEmail(value: emailController.text).isNotEmpty) {
      errorMessageEmail.value =
          Validators.checkErrorEmail(value: emailController.text);
    }

    //check match
    if (errorMessagePassword.value.isEmpty) {
      if (Validators.checkMatch(
              value_1: passwordController.text,
              value_2: passwordConfirmController.text)
          .isNotEmpty) {
        errorMessagePasswordConfirm.value = Validators.checkMatch(
            value_1: passwordController.text,
            value_2: passwordConfirmController.text);
      }
    }

    // Nếu có lỗi, không thực hiện đăng ký
    if (errorMessageName.value.isNotEmpty ||
        errorMessageEmail.value.isNotEmpty ||
        errorMessagePassword.value.isNotEmpty ||
        errorMessagePasswordConfirm.value.isNotEmpty) {
      return;
    }

    // isLoading.value = true; // Bắt đầu loading
    print("Register");
    // Get.toNamed('/verify-otp');
    final apiService = ApiService("http://10.0.2.2:3000");

    final String endpoint = "/users/registerUser";

    final email = emailController.text;
    final password = passwordController.text;
    final phone = phoneNumber.text;
    final fullname = email.split('@').first;
    print('Fullname: $fullname');

    final data = {
      // "FULLNAME": fullname,
      // "EMAIL": email,
      // "PHONE_NUMBER": phone,
      // "PASSWORD": password
      "FULLNAME": fullname,
      "EMAIL": email,
      "PHONE_NUMBER": phone,
      "PASSWORD": password
    };
    print(data);
    try {
      print("1");
      final response = await apiService.postData(
        endpoint,
        data,
      );
      if (response['success'] == false) {
        errorMessageEmail.value = response['message'];
        errorMessageName.value = response['message'];
        Get.snackbar("Error", response['message']);
        return;
      }
      if (response['success'] == true) {
        Get.toNamed('/verify-otp',
            arguments:
                emailController.text); // Get.offAllNamed('/emailVerify');

        // Get.offAllNamed('/emailVerify');
      }
      print(response);
    } catch (e) {
      print("Error : $e");
    }
  }
}
