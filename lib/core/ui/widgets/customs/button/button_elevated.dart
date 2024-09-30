import 'package:flutter/widgets.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/button/elevated_button_widget.dart';

class ButtonElevated extends ElevatedButtonWidget {
  final VoidCallback onTap;
  final String iconChild;
  final String textChild;
  const ButtonElevated(
      {super.key,
      required this.onTap,
      required this.iconChild,
      required this.textChild
      })
      : super(
            ontap: onTap,
            icon: iconChild,
            text: textChild,
            padding: const EdgeInsets.all(AppDimens.paddingSpace15),
            fontWeight: FontWeight.w500,
            textSize: AppDimens.iconsSize20,
            backgroundcolor: AppColors.light,
            textColor: AppColors.textNormal,
            borderRadius: AppDimens.radius30
            );
}
