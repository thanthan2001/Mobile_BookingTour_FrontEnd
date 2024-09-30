

import 'package:flutter/widgets.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/customs/texts/text_base.dart';

class TextLight extends TextBase{
  final String contentChild;
  final Color colorChild;
  const TextLight({super.key, required this.contentChild,this.colorChild=AppColors.textNormal}):super(content:contentChild,size: AppDimens.textSize14,fontWeight: FontWeight.w200,color: colorChild);

}