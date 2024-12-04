import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/ui/widgets/button/button_widget.dart';

// ignore: must_be_immutable
class ButtonNormal extends ButtonWidget {
  final String textChild;
  final VoidCallback onTap;
  ButtonNormal({super.key, required this.textChild, required this.onTap})
      : super(
            text: textChild,
            ontap: onTap,
            padding: const EdgeInsets.all(AppDimens.paddingSpace15),
            fontWeight: FontWeight.w900,
            textSize: AppDimens.iconsSize20);
}
