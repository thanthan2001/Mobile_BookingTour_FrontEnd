import 'package:flutter/material.dart';
import 'package:reading_app/app.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/core/ui/widgets/text/text_widget.dart';

class IconButtonWidget extends StatelessWidget {
  final VoidCallback ontap;
  final String text;
  final IconData icon; // Sửa đổi từ String sang IconData
  final double? height;
  final double? textSize;
  final double? width;
  final Color? backgroundColor;
  final Color? textColor;
  final FontWeight? fontWeight;
  final bool? isBorder;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const IconButtonWidget({
    super.key,
    this.fontWeight = FontWeight.w600,
    required this.ontap,
    required this.icon, // Thay đổi ở đây
    required this.text,
    this.height = 55.0,
    this.width = double.infinity,
    this.isBorder = false,
    this.textColor = AppColors.white,
    this.backgroundColor,
    this.padding,
    this.textSize = AppDimens.textSize16,
    this.borderRadius = AppDimens.radius15,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // highlightColor: AppColors.primary.withOpacity(0.1),
      // splashColor: AppColors.primary.withOpacity(0.9),
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
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon, // Sử dụng widget Icon ở đây
              size: 30.0, // Kích thước của icon
              color: AppColors.primary, // Màu của icon
            ),
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
