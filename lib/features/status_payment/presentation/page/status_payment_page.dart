import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/button/elevated_button_widget.dart';
import 'package:reading_app/features/status_payment/presentation/controller/status_payment_controller.dart';

class StatusPaymentPage extends GetView<StatusPaymentController> {
  const StatusPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trạng thái thanh toán'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.offAllNamed('/main');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Success icon
            const Icon(
              Icons.check_circle,
              color: AppColors.success,
              size: 100,
            ),
            const SizedBox(height: 20),

            // Payment success text
            const Center(
              child: Text(
                "Thanh toán thành công", // Payment Successful in Chinese
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Additional details message
            Center(
              child: Text(
                controller.text, // Explanation of payment success
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Continue shopping button
            ElevatedButtonWidget(
              ontap: () {
                Get.offAllNamed('/main');
              },
              icon: '',
              text: 'Quay lại trang chủ', // Back to home page in Vietnamese
            ),
          ],
        ),
      ),
    );
  }
}
