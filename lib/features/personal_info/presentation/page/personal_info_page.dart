import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/features/personal_info/presentation/controller/personal_info_controller.dart';

class PersonalInfoPage extends GetView<PersonalInfoController> {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    var isEditing = false.obs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Obx(() => TextFormField(
                      controller: controller.fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Họ tên',
                        labelStyle: const TextStyle(color: AppColors.black),
                        filled: true,
                        fillColor: Colors.grey[100],
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.blueAccent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                      enabled: isEditing.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập họ tên';
                        }
                        return null;
                      },
                    )),
                const SizedBox(height: 16),
                // Email
                Obx(
                  () => TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: AppColors.black),
                      filled: true,
                      fillColor: Colors.grey[100],
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blueAccent),
                      ),
                    ),
                    enabled: isEditing.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập email';
                      } else if (!GetUtils.isEmail(value)) {
                        return 'Email không hợp lệ';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Số điện thoại
                Obx(() => TextFormField(
                      controller: controller.phoneNumberController,
                      decoration: InputDecoration(
                        labelText: 'Số điện thoại',
                        labelStyle: const TextStyle(color: AppColors.black),
                        filled: true,
                        fillColor: Colors.grey[100],
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.blueAccent),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.blueAccent),
                        ),
                      ),
                      enabled: isEditing.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số điện thoại';
                        }
                      },
                    )),
                const SizedBox(height: 16),
                // Mật khẩu
                // Thay thế phần ô nhập mật khẩu
                Obx(() {
                  return isEditing.value
                      ? TextFormField(
                          controller: controller.passwordController,
                          decoration: InputDecoration(
                            labelText: 'Mật khẩu hiện tại',
                            labelStyle: const TextStyle(color: AppColors.black),
                            filled: true,
                            hintText: "Nhập mật khẩu hiện tại",
                            fillColor: Colors.grey[100],
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.blueAccent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.blueAccent),
                            ),
                          ),
                          enabled: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập mật khẩu';
                            }
                            return null;
                          },
                        )
                      : Container();
                }),

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Obx(() => ElevatedButton(
                            onPressed: () {
                              isEditing.value = !isEditing.value;
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: AppColors.grey,
                            ),
                            child: Text(
                              isEditing.value ? 'Hủy' : 'Chỉnh sửa',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          )),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.savePersonalInfo();
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: AppColors.primary,
                        ),
                        child: const Text(
                          'Cập nhật',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
