import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/ui/widgets/customs/texts/text_base.dart';

class TextBig extends TextBase {
  final String contentChild;
  const TextBig({
    super.key,
    required this.contentChild,
  }) : super(
            content: contentChild,
            size: AppDimens.textSize30,
            fontWeight: FontWeight.w900);
}
