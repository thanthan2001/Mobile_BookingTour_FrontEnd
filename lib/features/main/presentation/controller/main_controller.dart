import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/features/nav/explore/di/explore_binding.dart';
import 'package:reading_app/features/nav/explore/presentation/controller/explore_controller.dart';
import 'package:reading_app/features/nav/explore/presentation/page/explore_page.dart';
import 'package:reading_app/features/nav/home/di/home_binding.dart';
import 'package:reading_app/features/nav/home/presentation/controller/home_controller.dart';
import 'package:reading_app/features/nav/home/presentation/page/home_page.dart';
import 'package:reading_app/features/nav/profile/di/profile_binding.dart';
import 'package:reading_app/features/nav/profile/presentation/controller/profile_controller.dart';
import 'package:reading_app/features/nav/profile/presentation/page/profile_page.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;

  // Các route tương ứng với mỗi tab
  final pages = <String>['/home', '/explore', '/profile'];
  @override
  void onInit() {
    super.onInit();
    // Khởi tạo các controller
    Get.lazyPut(() => ExploreController(Get.find()));
    Get.lazyPut(() => HomeController(Get.find()));
    Get.lazyPut(() => ProfileController());
  }

  // Hàm để tạo route và gắn binding
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return GetPageRoute(
          settings: settings,
          page: () => const HomePage(),
          binding: HomeBinding(),
          transition: Transition.fadeIn,
        );
      case '/explore':
        return GetPageRoute(
          settings: settings,
          page: () => const ExplorePage(),
          binding: ExploreBinding(),
          transition: Transition.fadeIn,
        );
      case '/profile':
        return GetPageRoute(
          settings: settings,
          page: () => const ProfilePage(),
          binding: ProfileBinding(),
          transition: Transition.fadeIn,
        );
      default:
        return null;
    }
  }

  // Điều hướng giữa các tab trong BottomNavigationBar
  void onChangeItemBottomBar(int index) {
    if (currentIndex.value == index) return; // Nếu tab không thay đổi
    currentIndex.value = index;
    Get.toNamed(
      pages[index],
      id: 10, // Sử dụng khóa nested navigator
    );
  }
}
