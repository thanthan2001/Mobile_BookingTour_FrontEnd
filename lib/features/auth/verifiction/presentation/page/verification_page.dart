import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/assets/app_images.dart';
import 'package:reading_app/core/configs/strings/app_contents.dart';
import 'package:reading_app/core/ui/widgets/customs/button/button_normal.dart';
import 'package:reading_app/core/ui/widgets/customs/texts/text_normal.dart';
import 'package:reading_app/core/ui/widgets/customs/texts/title_normal.dart';
import 'package:reading_app/features/auth/shared/build_share_auth.dart';
import 'package:reading_app/features/auth/verifiction/presentation/controller/verification_controller.dart';

class VerificationPage extends GetView<VerificationController> {
  const VerificationPage({super.key});
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        await controller.deleteUserIfNotVerified();
        return true; // Cho phép back
      },
      child: BuildShareAuth.buildMainBodyPage(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildShareAuth.buildTitle(
                title: AppContents.verification,
                subTitle: AppContents.subVerification),
            _BuildBody()
          ],
        ),
        isLoading: false.obs,
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _BuildBody() {
    return BuildShareAuth.buildBackgoundForm(
      childContent: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: AppDimens.paddingSpace20),
                    child: Image.asset(
                      AppImages.iEmailVerify,
                      width: AppDimens.iconsSize100,
                    ),
                  ),
                  const TitleNormal(
                      contentChild: AppContents.checkEmailForVerifiaction),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: AppDimens.paddingSpace20),
                    width: Get.width * .8,
                    child: const TextNormal(
                      contentChild: AppContents.subCheckEmailForVerifiaction,
                      textCenter: true,
                    ),
                  )
                ],
              )
            ],
          ),
          ButtonNormal(
              textChild: AppContents.cancel,
              onTap: () async {
                await controller.deleteUserIfNotVerified();
                Get.back();
              }),
          const SizedBox(
            height: AppDimens.paddingSpace15,
          ),
        ],
      ),
    );
  }
}
