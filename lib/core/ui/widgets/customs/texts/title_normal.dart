import 'dart:ui';

import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';

class TitleNormal extends TextWidget {
  final String contentChild;
  final Color colorChild;
  const TitleNormal(
      {super.key,
      required this.contentChild,
      this.colorChild = AppColors.textNormal})
      : super(
            text: contentChild,
            color: colorChild,
            size: AppDimens.textSize22,
            fontWeight: FontWeight.w500);
}
