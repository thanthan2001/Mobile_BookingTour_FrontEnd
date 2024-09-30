import 'dart:ui';

import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/customs/texts/text_base.dart';

class TextNormal extends TextBase {
  final String contentChild;
  final Color colorChild;
  final bool textCenter;
  const TextNormal({
    super.key,
    required this.contentChild,
    this.colorChild = AppColors.textNormal,
    this.textCenter=false,
  }) : super(
            content: contentChild,
            size: AppDimens.textSize14,
            fontWeight: FontWeight.w400,
            color: colorChild,
            center: textCenter
            );
}
