import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/ui/widgets/customs/button/button_normal.dart';
import 'package:reading_app/core/ui/widgets/customs/inputs/input_app_normal.dart';
import 'package:reading_app/features/auth/register/presentation/controller/register_controller.dart';
import 'package:reading_app/features/auth/shared/build_share_auth.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BuildShareAuth.buildMainBodyPage(
      appbar: BuildShareAuth.buildAppbar(),
      body: Column(
        children: [
          BuildShareAuth.buildTitle(
            title: AppContents.subtitleSignUp,
            subTitle: AppContents.subSignUp,
          ),
          _BuildBody()
        ],
      ),
      isLoading: controller.isLoading,
    );
  }

  // ignore: non_constant_identifier_names
  Widget _BuildBody() {
    // Khởi tạo các controllers cho các InputAppNormal
    return BuildShareAuth.buildBackgoundForm(
        childContent: Obx(
      () => Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InputAppNormal(
            prefixIcon: const Icon(Icons.phone),
            lable: AppContents.phoneNumber,
            placeholder: AppContents.placeholderName,
            controller: controller.phoneNumber, // Cung cấp controller
            errorMess: controller.errorMessageName.value,
          ),
          InputAppNormal(
            prefixIcon: const Icon(Icons.alternate_email),
            lable: AppContents.email,
            placeholder: AppContents.placeholderEmail,
            controller: controller.emailController, // Cung cấp controller
            errorMess: controller.errorMessageEmail.value,
          ),
          InputAppNormal(
            prefixIcon: const Icon(Icons.lock),
            lable: AppContents.password,
            placeholder: AppContents.placeholderPassword,
            isPassword: true,
            controller: controller.passwordController, // Cung cấp controller
            errorMess: controller.errorMessagePassword.value,
          ),
          InputAppNormal(
            prefixIcon: const Icon(Icons.check),
            lable: AppContents.passwordConfirm,
            placeholder: AppContents.placeholderPassword,
            isPassword: true,
            controller:
                controller.passwordConfirmController, // Cung cấp controller
            errorMess: controller.errorMessagePasswordConfirm.value,
          ),
          ButtonNormal(
            textChild: AppContents.signUp,
            onTap: () async {
              // Gọi phương thức đăng ký từ RegisterController
              await controller.register();
              // Điều hướng đến trang xác minh email nếu cần
            },
          )
        ],
      ),
    ));
  }
}
