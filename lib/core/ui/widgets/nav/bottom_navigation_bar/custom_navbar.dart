import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/features/main/presentation/controller/main_controller.dart';

// ignore: must_be_immutable
class CustomNavbar extends GetView<MainController> {
  final double radiusFull = AppDimens.radiusFull;
  final Color primaryColor = AppColors.primary;
  final Color whiteColor = Colors.white;

  const CustomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: AppDimens.paddingSpace10,
      left: Get.width * 0.1,
      right: Get.width * 0.1,
      child: Container(
        padding: const EdgeInsets.all(AppDimens.paddingSpace5),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(radiusFull),
        ),
        child: Obx(() {
          return AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconButton(Icons.home, 0),
                _buildIconButton(Icons.search, 1),
                _buildIconButton(Icons.add_outlined, 2),
                _buildIconButton(Icons.shopping_cart, 3),
                _buildIconButton(Icons.person, 4),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, int index) {
    bool isActive = controller.currentIndex.value == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isActive ? AppColors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(AppDimens.radiusFull),
      ),
      child: IconButton(
        onPressed: () => controller.onChangeItemBottomBar(index),
        icon: Icon(icon),
        iconSize: isActive ? AppDimens.iconsSize30 : AppDimens.iconsSize30,
        color: isActive ? AppColors.primary : AppColors.white,
      ),
    );
  }
}
