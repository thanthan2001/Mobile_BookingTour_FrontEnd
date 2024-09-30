import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';

// ignore: Custom IconButton
class iconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const iconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(.2),
            spreadRadius: 1,
            blurRadius: 2,
          )
        ],
        color: Color.fromARGB(157, 255, 255, 255),
      ),
      child: IconButton(
        iconSize: 30,
        icon: Icon(icon),
        onPressed: () => onPressed(),
      ),
    );
  }
}
