import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/customs/texts/text_base.dart';

class Lable extends TextBase {
  final String contentChild;
  const Lable({super.key, required this.contentChild})
      : super(
            color: AppColors.textNormal,
            fontWeight: FontWeight.w400,
            size: AppDimens.iconsSize14,
            content: contentChild);
}
