import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/services/api_service.dart';
import 'package:reading_app/core/utils/validator.dart';

class VerifyOTPController extends GetxController {
  final TextEditingController OTPController = TextEditingController();
  var email = ''.obs;
  var errorMsgOTP = ''.obs;
  var isLoading = false.obs;
  var countdown = 60.obs; // Biến đếm ngược 60 giây
  Timer? _timer; // Biến để quản lý Timer
  @override
  void onInit() {
    super.onInit();
    startCountdown(); // Bắt đầu đếm ngược khi vào trang
    email.value = Get.arguments; // Lấy tham số email từ Get.arguments
    print("Email received: ${email.value}"); // Kiểm tra email nhận được
  }

  void startCountdown() {
    countdown.value = 60;
    _timer?.cancel(); // Hủy timer hiện tại nếu có
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        timer.cancel();
      }
    });
  }

  // Hàm gửi lại mã OTP
  Future<void> resendOTP() async {
    // Logic gửi lại mã OTP
    startCountdown(); // Reset lại đếm ngược
    // ...
    print("Resend OTP to: ${email.value}");
  }

  Future<void> verifyOTP() async {
    // Reset lỗi của OTP
    errorMsgOTP.value = '';

    // Kiểm tra độ dài OTP
    final otpError = await Validators.checkErrorsLength(
        value: OTPController.text, minLenth: 4, maxLength: 8);

    if (otpError.isNotEmpty) {
      errorMsgOTP.value = "OTP " + otpError;
    }
    // Nếu có lỗi, không thực hiện verify
    if (errorMsgOTP.value.isNotEmpty) {
      return;
    }
    print(email.value); // Kiểm tra email
    final apiService = ApiService("http://10.0.2.2:3000");

    final String endpoint = "/users/verifyOTPAndActivateUser";

    final data = {
      "email": email.value,
      "otp": OTPController.text,
    };

    print(data);
    try {
      final response = await apiService.postData(
        endpoint,
        data,
      );
      if (response["success"] == false && response["type"] == "errorOTP") {
        Get.snackbar("Error", response["errors"]);
        print("1==============================");
        errorMsgOTP.value = response["errors"];
      }

      if (response["success"] == false && response["type"] == "expTimeOTP") {
        Get.snackbar("Error", response["errors"]);
        print("1==============================");
        errorMsgOTP.value = response["errors"];
      }

      if (response["succes"] == true) {
        Get.snackbar("Success", response["message"]);
        Get.offAllNamed('/login');
      }
      print(response);
    } catch (e) {
      print("Error : $e");
    }
  }
}
