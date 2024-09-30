import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final VoidCallback ontap;
  final String text;
  final String icon;
  final double? height;
  final double? textSize;
  final double? width;
  final Color? backgroundcolor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final bool? isBorder;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  const ElevatedButtonWidget({
    super.key,
    this.fontWeight = FontWeight.w600,
    required this.ontap,
    required this.icon,
    required this.text,
    this.height = 55.0,
    this.width = double.infinity,
    this.isBorder = false,
    this.textColor = AppColors.white,
    this.backgroundcolor = AppColors.primary,
    this.padding,
    this.textSize = AppDimens.textSize16,
    this.borderRadius = AppDimens.radius15,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: isBorder == true
              ? Border.all(
                  width: 1.5,
                  color: AppColors.primary.withOpacity(0.9),
                )
              : null,
          color: backgroundcolor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon.isNotEmpty
                ? Image.asset(
                    icon,
                    height: 20.0,
                    width: 20.0,
                  )
                : const SizedBox.shrink(),
            text.isNotEmpty
                ? const SizedBox(width: 10.0)
                : const SizedBox.shrink(),
            TextWidget(
              text: text,
              fontWeight: fontWeight,
              color: textColor,
              size: textSize,
            ),
          ],
        ),
      ),
    );
  }
}
