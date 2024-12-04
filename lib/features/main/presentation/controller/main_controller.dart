import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/features/nav/explore/di/explore_binding.dart';
import 'package:reading_app/features/nav/explore/presentation/page/explore_page.dart';
import 'package:reading_app/features/nav/home/di/home_binding.dart';
import 'package:reading_app/features/nav/home/presentation/page/home_page.dart';
import 'package:reading_app/features/nav/list_tour/di/list_tour_binding.dart';
import 'package:reading_app/features/nav/list_tour/presentation/page/list_tour_page.dart';
import 'package:reading_app/features/nav/profile/di/profile_binding.dart';
import 'package:reading_app/features/nav/profile/presentation/page/profile_page.dart';

class MainController extends GetxController {
  RxInt currentIndex = 0.obs;
  final pages = <String>['/home', '/explore', '/list', '/profile'];

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
      case '/list':
        print("Navigating to ListTourPage");
        return GetPageRoute(
          settings: settings,
          page: () => const ListTourPage(),
          binding: ListTourBinding(),
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

  void onChangeItemBottomBar(int index) {
    if (currentIndex.value == index) return;
    currentIndex.value = index;
    Get.offNamed(pages[index], id: 10);
  }
}
