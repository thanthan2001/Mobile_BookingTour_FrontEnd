import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'dart:convert';
import 'dart:developer'; // For logging

import '../../../../core/services/api_service.dart'; // For your API Service

class VNPayController extends GetxController {
  late final WebViewController webViewController;
  var isLoading = true.obs;
  final URL_Payment = Get.arguments;
  @override
  void onInit() {
    super.onInit();
    _initializeWebView();
  }

  void _initializeWebView() {
    // Khởi tạo WebView dựa trên nền tảng.
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    webViewController = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            isLoading.value = progress < 100;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) async {
            isLoading.value = false;
            log("Page finished loading: $url");

            // Kiểm tra nếu URL là `vnp_ReturnUrl`
            if (url.contains("/payments/vnpay_return")) {
              Get.toNamed("/status-payment", arguments: url);
            }
          },
          onWebResourceError: (WebResourceError error) {
            print('''Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
            ''');
          },
        ),
      )
      ..loadRequest(Uri.parse(URL_Payment));
  }
}
