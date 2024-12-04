import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/const/enum.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';

class DialogsUtils {
  static void showAlterLoading() {
    Get.dialog(Dialog(
      backgroundColor: AppColors.white.withOpacity(0.8),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Đặt giá trị border radius tùy chọn
      ),
      child: Container(
        height: 160,
        width: 40,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Lottie.asset('assets/jsons/loading.json', height: 60.0),
            const SizedBox(height: 10),
            const TextWidget(
              text: "Loading....",
              fontWeight: FontWeight.w600,
            ),
            LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.primary,
              size: 40,
            ),
          ],
        ),
      ),
    ));
  }

  static void showAlertDialog2({
    required String title,
    required String message,
    required TypeDialog typeDialog,
    VoidCallback? onPresss,
  }) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFFEBEDF0),
        elevation: 50.0,
        contentPadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFFEBEDF0), width: 4.0),
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        content: Wrap(
          children: [
            Container(
              width: 337,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: AppColors.white,
              ),
              child: Column(
                children: [
                  Container(
                    width: 30.0,
                    height: 30.0,
                    margin: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: TypeDialog.success == typeDialog
                          ? AppColors.primary
                          : AppColors.red,
                    ),
                    child: TypeDialog.success == typeDialog
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.priority_high,
                            color: Colors.white,
                          ),
                  ),
                  title.isNotEmpty
                      ? Text(
                          title.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimens.textSize18,
                              color: AppColors.black),
                        )
                      : const SizedBox.shrink(),
                  Container(
                    width: 300.0,
                    margin: const EdgeInsets.only(
                        top: 16.0, bottom: 22.0, left: 10.0, right: 10),
                    child: Text(
                      message.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: AppDimens.textSize16,
                          color: Color(0xFF4B5767)),
                    ),
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0)),
                      color: Color(0xFFEBEDF0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFFD2D3D4),
                              elevation: 0.0,
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.zero,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Hủy',
                              style: TextStyle(
                                fontSize: AppDimens.textSize18,
                                color: AppColors.black,
                              ),
                            ),
                            onPressed: () {
                              Get.back(); // Đóng dialog
                            },
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFFD2D3D4),
                              elevation: 0.0,
                              backgroundColor: const Color(0xFFEBEDF0),
                              padding: EdgeInsets.zero,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10.0),
                                ),
                              ),
                            ),
                            child: const Text(
                              'Xác nhận',
                              style: TextStyle(
                                fontSize: AppDimens.textSize18,
                                color: Colors.red,
                              ),
                            ),
                            onPressed: () {
                              if (onPresss != null) {
                                onPresss();
                              }
                              Get.back(); // Đóng dialog
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void showAlertDialog({
    required String title,
    required String message,
    required TypeDialog typeDialog,
    VoidCallback? onPresss,
  }) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFFEBEDF0),
        elevation: 50.0,
        contentPadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Color(0xFFEBEDF0), width: 4.0),
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        content: Wrap(
          children: [
            Container(
              width: 337,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: AppColors.white,
              ),
              child: Column(
                children: [
                  Container(
                    width: 30.0,
                    height: 30.0,
                    margin: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: typeDialog == TypeDialog.error
                            ? AppColors.red
                            : AppColors.primary),
                    child: Icon(
                      typeDialog == TypeDialog.error
                          ? Icons.priority_high
                          : Icons.check,
                      color: Colors.white,
                    ),
                  ),
                  title.isNotEmpty
                      ? Text(
                          title.tr,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppDimens.textSize18,
                              color: AppColors.black),
                        )
                      : const SizedBox.shrink(),
                  Container(
                    width: 300.0,
                    margin: const EdgeInsets.only(
                        top: 16.0, bottom: 22.0, left: 10.0, right: 10),
                    child: Text(
                      message.tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: AppDimens.textSize16,
                          color: Color(0xFF4B5767)),
                    ),
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0)),
                      color: Color(0xFFEBEDF0),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFFD2D3D4),
                        elevation: 0.0,
                        backgroundColor: const Color(0xFFEBEDF0),
                        padding: EdgeInsets.zero, // foreground
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          fontSize: AppDimens.textSize18,
                          color: AppColors.black,
                        ),
                      ),
                      onPressed: () {
                        if (onPresss != null) {
                          onPresss();
                        }
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
