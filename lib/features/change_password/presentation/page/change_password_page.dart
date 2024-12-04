import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/features/change_password/presentation/controller/change_password_controller.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Đổi mật khẩu'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Obx(() => TextFormField(
                    controller: controller.oldPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu cũ',
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(controller.isOldPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          controller.isOldPasswordVisible.toggle();
                        },
                      ),
                    ),
                    obscureText: !controller.isOldPasswordVisible.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu cũ';
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 10),
              Obx(() => TextFormField(
                    controller: controller.newPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu mới',
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(controller.isNewPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          controller.isNewPasswordVisible.toggle();
                        },
                      ),
                    ),
                    obscureText: !controller.isNewPasswordVisible.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu mới';
                      } else if (value.length < 6) {
                        return 'Mật khẩu mới phải có ít nhất 6 ký tự';
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 10),
              Obx(() => TextFormField(
                    controller: controller.confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Nhập lại mật khẩu mới',
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(controller.isConfirmPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          controller.isConfirmPasswordVisible.toggle();
                        },
                      ),
                    ),
                    obscureText: !controller.isConfirmPasswordVisible.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập lại mật khẩu mới';
                      } else if (value !=
                          controller.newPasswordController.text) {
                        return 'Mật khẩu không trùng khớp';
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      controller.changePassword();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide.none,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Đổi mật khẩu',
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
