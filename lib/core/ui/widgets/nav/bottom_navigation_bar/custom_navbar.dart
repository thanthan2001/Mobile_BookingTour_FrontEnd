import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/configs/app_dimens.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';
import 'package:reading_app/features/main/presentation/controller/main_controller.dart';
import 'package:reading_app/features/nav/explore/presentation/page/explore_page.dart';
import 'package:reading_app/features/nav/home/presentation/page/home_page.dart';
import 'package:reading_app/features/nav/profile/presentation/page/profile_page.dart';

class CustomNavbar extends GetView<MainController> {
  final double radiusFull = AppDimens.radiusFull;
  final Color primaryColor = AppColors.primary;
  final Color whiteColor = Colors.white;

  const CustomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return IndexedStack(
          index: controller.currentIndex.value,
          children: [
            Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (_) => HomePage(),
              ),
            ),
            Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (_) => ExplorePage(),
              ),
            ),
            Navigator(
              onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (_) => ProfilePage(),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.onChangeItemBottomBar(index); // Thay đổi trang
          },
          backgroundColor: primaryColor,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.white,
          items: [
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.home, 0),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.search, 1),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: _buildIcon(Icons.person, 2),
              label: 'Profile',
            ),
          ],
        );
      }),
    );
  }

  // Hàm tùy chỉnh để xây dựng icon cho BottomNavigationBar
  Widget _buildIcon(IconData icon, int index) {
    bool isActive = controller.currentIndex.value == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isActive ? AppColors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(AppDimens.radiusFull),
      ),
      child: Icon(
        icon,
        size: AppDimens.iconsSize30,
        color: isActive ? AppColors.primary : AppColors.white,
      ),
    );
  }
}
