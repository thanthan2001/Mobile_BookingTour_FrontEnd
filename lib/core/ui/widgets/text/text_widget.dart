import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final List<Shadow>? listShadow;
  final TextDecoration? textDecoration;
  final FontStyle? fontStyle;
  final String? fontFamily; // Add the fontFamily parameter

  const TextWidget({
    super.key,
    this.textAlign,
    this.listShadow,
    this.maxLines = 1000,
    required this.text,
    this.color = AppColors.black,
    this.size = AppDimens.textSize18,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.textDecoration = TextDecoration.none,
    this.fontFamily, // Initialize the fontFamily parameter
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text.tr,
      maxLines: maxLines,
      textAlign: textAlign,
      style: GoogleFonts.getFont(
        fontFamily ?? "Roboto", // Use the custom font family or default to Nunito Sans
        textStyle: TextStyle(
          color: color,
          fontSize: size,
          fontStyle: fontStyle,
          shadows: listShadow,
          fontWeight: fontWeight,
          decoration: textDecoration,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
