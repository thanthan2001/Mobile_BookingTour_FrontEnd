import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20.0,
      width: 20.0,
      child: CircularProgressIndicator(
        color: AppColors.white,
      ),
    );
  }
}