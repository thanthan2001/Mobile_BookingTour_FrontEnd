import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/features/vnpay_payment/presentation/controller/vnpay_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VNPayPage extends GetView<VNPayController> {
  const VNPayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => controller.webViewController.reload(),
          ),
        ],
      ),
      body: Obx(() => Stack(
            children: [
              WebViewWidget(controller: controller.webViewController),
              controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox.shrink(),
            ],
          )),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final url = await controller.webViewController.currentUrl();
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(content: Text('Favorited $url')),
      //     );
      //   },
      //   child: const Icon(Icons.favorite),
      // ),
    );
  }
}
