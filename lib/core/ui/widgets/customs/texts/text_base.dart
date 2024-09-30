import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';

class TextBase extends StatelessWidget {
  final String content;
  final Color color;
  final double size;
  final FontWeight fontWeight;
  final bool center;
  const TextBase({
    super.key,
    required this.content,
    this.color = AppColors.white,
    required this.size, 
    required this.fontWeight,
    this.center=false
  });

  @override
  Widget build(BuildContext context) {
    return TextWidget(
      fontFamily: "Roboto",
      text: content,
      color: color,
      size:size,
      fontWeight: fontWeight,
      textAlign: center ? TextAlign.center :null,
    );
  }
}
