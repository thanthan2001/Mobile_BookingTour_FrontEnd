import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/ui/widgets/customs/button/button_normal.dart';
import 'package:reading_app/core/ui/widgets/customs/inputs/input_app_normal.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';
import 'package:reading_app/features/auth/shared/build_share_auth.dart';
import 'package:reading_app/features/auth/verify_otp/presentation/controller/verify_controller.dart';

class VerifyPage extends GetView<VerifyOTPController> {
  const VerifyPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BuildShareAuth.buildMainBodyPage(
      appbar: BuildShareAuth.buildAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildShareAuth.buildTitle(
              title: AppContents.verifyAccount,
              subTitle: AppContents.subVerifyAccount),
          _BuildBody()
        ],
      ),
      isLoading: false.obs,
    );
  }

  // ignore: non_constant_identifier_names
  Widget _BuildBody() {
    return Obx(
      () => BuildShareAuth.buildBackgoundForm(
        childContent: Column(
          children: [
            SizedBox(
              height: Get.height * .08,
            ),
            InputAppNormal(
              lable: AppContents.OTP,
              placeholder: AppContents.placeholderOTP,
              controller: controller.OTPController,
              errorMess: controller.errorMsgOTP.value,
            ),
            // Hiển thị nút Resend hoặc Countdown
            Obx(() {
              return TextButton(
                onPressed: controller.countdown.value == 0
                    ? () async {
                        await controller.resendOTP();
                      }
                    : null, // Disable nút khi countdown > 0
                child: TextWidget(
                  text: controller.countdown.value == 0
                      ? AppContents.resendCode
                      : '${AppContents.resendCode} (${controller.countdown.value}s)',
                  color: controller.countdown.value == 0
                      ? Colors.blue
                      : Colors.grey, // Đổi màu khi countdown > 0
                ),
              );
            }),
            SizedBox(
              height: 5,
            ),
            ButtonNormal(
                textChild: AppContents.sendCode,
                onTap: () async {
                  await controller.verifyOTP();
                })
          ],
        ),
      ),
    );
  }
}
