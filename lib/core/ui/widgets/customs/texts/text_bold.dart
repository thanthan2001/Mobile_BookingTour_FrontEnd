import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/ui/widgets/customs/texts/text_base.dart';

// ignore: camel_case_types
class TextBold extends TextBase {
  final String contentChild;
  const TextBold({
    super.key,
    required this.contentChild,
  }) : super(content: contentChild,size: AppDimens.iconsSize16,fontWeight: FontWeight.w500);
}
