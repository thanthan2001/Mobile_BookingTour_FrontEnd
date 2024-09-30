import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/assets/app_images.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/routes/routes.dart';
import 'package:reading_app/core/ui/widgets/customs/button/button_elevated.dart';
import 'package:reading_app/core/ui/widgets/customs/button/button_normal.dart';
import 'package:reading_app/core/ui/widgets/customs/inputs/input_app_normal.dart';
import 'package:reading_app/core/ui/widgets/customs/texts/text_light.dart';
import 'package:reading_app/core/ui/widgets/customs/texts/text_normal.dart';
import 'package:reading_app/features/auth/login/presentation/controller/login_controller.dart';
import 'package:reading_app/features/auth/shared/build_share_auth.dart';

class LoginPage extends GetView<LogInController> {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BuildShareAuth.buildMainBodyPage(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildShareAuth.buildTitle(
              title: AppContents.sloganLogin, subTitle: AppContents.subLogin),
          _BuildBody()
        ],
      ),
      isLoading: controller.isLoading,
    );
  }

  // ignore: non_constant_identifier_names
  Widget _BuildBody() {
    return BuildShareAuth.buildBackgoundForm(
      childContent: Wrap(
        runSpacing: AppDimens.paddingSpace10,
        children: [
          Obx(
            () => InputAppNormal(
              lable: AppContents.email,
              prefixIcon: const Icon(Icons.alternate_email),
              placeholder: AppContents.placeholderEmail,
              controller: controller.emailController, // Cung cấp controller
              errorMess: controller.errorMessageEmail.value,
            ),
          ),
          Obx(
            () => InputAppNormal(
              prefixIcon: const Icon(Icons.lock),
              lable: AppContents.password,
              placeholder: AppContents.placeholderPassword,
              isPassword: true,
              controller: controller.passwordController,
              errorMess: controller.errorMessagePassword.value,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Obx(
              //   () => CustomCheckBox(
              //     onChanged: (value) {
              //       controller.toggleCheck();
              //     },
              //     value: controller.isCheckRememberAccount.value,
              //     borderColor: AppColors.textNormal,
              //     checkBoxSize: AppDimens.iconsSize16,
              //     checkedFillColor: AppColors.primary,
              //   ),
              // ),
              // const TextLight(
              //     contentChild: AppContents.rememberMe,
              //     colorChild: AppColors.textLightActive),
              const Spacer(),
              InkWell(
                  onTap: () {
                    Get.toNamed(Routes.forgotPassword);
                  },
                  child: const TextLight(
                      contentChild: AppContents.forgotPassword,
                      colorChild: Color.fromARGB(255, 6, 128, 249))),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          ButtonNormal(
              textChild: AppContents.login,
              onTap: () async {
                await controller.login();
              }),
          _BuildLoginMethod()
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Column _BuildLoginMethod() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextNormal(contentChild: AppContents.dontHaveAnAccount),
            InkWell(
              onTap: () => Get.toNamed(Routes.register),
              child: const TextNormal(
                contentChild: AppContents.createHere,
                colorChild: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: AppDimens.paddingSpace10,
        ),
        const TextNormal(contentChild: AppContents.or),
        const SizedBox(
          height: AppDimens.paddingSpace10,
        ),
        ButtonElevated(
          iconChild: AppImages.iGoogle,
          onTap: () async {
            await controller.logInWithGoogle();
          },
          textChild: AppContents.loginWithGoogle,
        ),
      ],
    );
  }
}
