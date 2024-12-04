import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/ui/widgets/button/elevated_button_widget.dart';

import '../../../../core/configs/themes/app_colors.dart';
import '../controller/infor_payment_controller.dart';

class InforPaymentPage extends GetView<InforPaymentController> {
  const InforPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: const Text(
          'Thông tin thanh toán',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Get.back(); // Điều hướng về trang trước đó
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Đảm bảo các phần tử căn trái
          children: [
            _buildTextField(
              'Họ và Tên',
              'Nhập Họ và Tên',
              controller.fullName,
              required: true,
              errorText: controller.fullNameError,
            ),
            const SizedBox(height: 10), // Giảm khoảng cách giữa các field
            _buildTextField(
              'Số CMND/CCCD',
              'Nhập CMND/CCCD',
              controller.citizen,
              required: true,
              errorText: controller.citizenError,
            ),
            const SizedBox(height: 10), // Giảm khoảng cách giữa các field
            _buildPhoneField(
                'Số điện thoại', 'Nhập số điện thoại', controller.phoneNumber),
            const SizedBox(
                height: 20), // Khoảng cách trước nút Tiến hành thanh toán
            _buildCheckOutButton(),
          ],
        ),
      ),
    );
  }

  // Widget TextField với lỗi
  Column _buildTextField(String label, String hint, RxString text,
      {bool required = false, RxString? errorText, IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label ${required ? '*' : ''}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5), // Giảm khoảng cách giữa label và TextField
        Obx(() {
          bool hasError = errorText?.value.isNotEmpty ?? false; // Kiểm tra lỗi
          return TextField(
            onChanged: (value) => text.value = value,
            decoration: InputDecoration(
              hintText: hint,
              suffixIcon: icon != null ? Icon(icon) : null,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              errorText:
                  hasError ? errorText?.value : null, // Hiển thị lỗi nếu có
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                    color: Colors.red), // Màu viền đỏ khi có lỗi
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                    color: Colors.red), // Viền đỏ khi đang focus và có lỗi
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: hasError
                        ? Colors.red
                        : Colors.blue), // Viền xanh khi focus và không có lỗi
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: Colors.grey), // Viền mặc định
              ),
            ),
          );
        }),
        const SizedBox(height: 3), // Giảm khoảng cách giữa TextField và lỗi
        // Obx(() {
        //   return Text(
        //     errorText?.value ?? '',
        //     style: const TextStyle(
        //         color: Colors.red, fontSize: 12), // Hiển thị lỗi
        //   );
        // }),
      ],
    );
  }

  // Widget Phone Field
  Widget _buildPhoneField(String label, String hint, RxString phoneNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label *',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Màu viền xám mặc định
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                '🇻🇳', // Flag placeholder
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Obx(() {
                bool hasError = controller.phoneNumberError.value.isNotEmpty;
                return TextField(
                  onChanged: (value) => phoneNumber.value = value,
                  decoration: InputDecoration(
                    hintText: hint,
                    filled: true,
                    fillColor: Colors.grey[200],
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey, // Viền mặc định màu xám
                      ),
                    ),
                    errorText:
                        hasError ? controller.phoneNumberError.value : null,
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.red, // Viền màu đỏ khi có lỗi
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.red, // Viền đỏ khi focus và có lỗi
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: hasError
                            ? Colors.red
                            : Colors.blue, // Viền xanh khi focus không lỗi
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey, // Viền mặc định xám khi không focus
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
        const SizedBox(height: 3), // Giảm khoảng cách giữa TextField và lỗi
        // Obx(() {
        //   return Text(
        //     controller.phoneNumberError.value,
        //     style: const TextStyle(color: Colors.red, fontSize: 12),
        //   );
        // }),
      ],
    );
  }

  // Widget Nút Lưu thông tin
  Widget _buildCheckOutButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButtonWidget(
        ontap: () {
          controller.hanlePayment();
        },
        icon: '',
        text: 'Tiến hành thanh toán',
      ),
    );
  }
}
