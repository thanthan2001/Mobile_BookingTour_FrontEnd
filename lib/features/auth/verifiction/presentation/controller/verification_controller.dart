import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/const/enum.dart';
import 'package:reading_app/core/configs/const/prefs_constants.dart';
import 'package:reading_app/core/configs/strings/messages/app_errors.dart';
import 'package:reading_app/core/configs/strings/messages/app_notify.dart';
import 'package:reading_app/core/configs/strings/messages/app_success.dart';
import 'package:reading_app/core/data/firebase/firebae_auth/firebase_auth.dart';
import 'package:reading_app/core/data/firebase/firestore_database/firestore_user.dart';
import 'package:reading_app/core/data/firebase/model/user_model.dart';
import 'package:reading_app/core/data/prefs/prefs.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/snackbar/snackbar.dart';

class VerificationController extends GetxController
    with WidgetsBindingObserver {
  Timer? _timer;
  final Prefs prefs;
  VerificationController(this.prefs);
  var isLoading = false.obs;

  UserModel? userDataArgument;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    userDataArgument = Get.arguments as UserModel;
    startEmailVerificationCheck();
  }

  @override
  void onClose() {
    _timer?.cancel(); // Huỷ bỏ Timer khi controller bị huỷ
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      deleteUserIfNotVerified();
    }
  }

  // Lắng nghe sự kiện back của hệ thống
  Future<bool> onWillPop() async {
    await deleteUserIfNotVerified();
    return true; // Cho phép back
  }

  // Phương thức bắt đầu kiểm tra trạng thái xác thực email định kỳ
  void startEmailVerificationCheck() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await checkEmailVerificationStatus();
    });
  }

  // Phương thức kiểm tra trạng thái xác thực email và chuyển hướng nếu cần
  Future<void> checkEmailVerificationStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload(); // Tải lại thông tin người dùng
      user = FirebaseAuth.instance.currentUser; // Cập nhật thông tin người dùng
      if (user!.emailVerified) {
        _timer?.cancel(); // Huỷ bỏ Timer khi email đã được xác thực
        SnackbarUtil.showSuccess(AppSuccess.verifySuccess);
        isLoading.value = true;
        if (userDataArgument != null) {
          await FirestoreUser.createUser(userDataArgument!);
          await prefs.remove(PrefsConstants.idAccountwaitingVerify);
        }
        isLoading.value = false;
        Get.offAllNamed(Routes.login, arguments: user.email);
      }
    } else {
      print('No user logged in.');
    }
  }

  // Phương thức xóa tài khoản nếu chưa được xác thực
  Future<void> deleteUserIfNotVerified() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && !user.emailVerified) {
      await user.delete();
    }
  }

  // Phương thức gửi lại email xác thực
  Future<void> handleVerification() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (!user.emailVerified) {
        final result = await FirebaseAuthentication.sendMailVerify();
        if (result.status == Status.success) {
          SnackbarUtil.showSuccess(AppSuccess.resendVerify);
        } else {
          SnackbarUtil.showError(AppErrors.emailAlready);
        }
      } else {
        SnackbarUtil.showInfo(AppNotify.emailAlready);
      }
    } else {
      SnackbarUtil.showError(AppErrors.noUerLogin);
    }
  }
}
