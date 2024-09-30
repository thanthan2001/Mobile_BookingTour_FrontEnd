import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';

class IconCircle extends StatelessWidget {
  final double paddingWithChild;
  final IconData?
      iconChild; // Nullable IconData to accept either an icon or null
  final Image? imageChild; // Image widget to accept an image
  final double iconSize;
  final Color iconColor;
  final VoidCallback onTap;

  const IconCircle({
    super.key,
    this.paddingWithChild = AppDimens.paddingSpace5,
    this.iconChild, // Make iconChild optional
    this.imageChild, // Make imageChild optional
    this.iconSize = AppDimens.iconsSize25,
    this.iconColor = AppColors.black,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Decide which child to display based on whether imageChild or iconChild is provided
    final Widget? child =
        imageChild ?? (iconChild != null ? Icon(iconChild) : null);

    return Container(
      padding: EdgeInsets.all(paddingWithChild),
      decoration: BoxDecoration(
        // color: AppColors.white,
        borderRadius: BorderRadius.circular(10000),
        color: Color.fromARGB(157, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(.2),
            spreadRadius: 1,
            blurRadius: 2,
          )
        ],
      ),
      child: IconButton(
        iconSize: iconSize,
        color: iconColor,
        onPressed: onTap,
        icon: child ?? Container(), // Display the child if it's not null
      ),
    );
  }
}
