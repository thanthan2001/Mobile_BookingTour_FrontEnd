import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/features/nav/explore/di/explore_binding.dart';
import 'package:reading_app/features/nav/explore/presentation/page/explore_page.dart';
import 'package:reading_app/features/nav/home/di/home_binding.dart';
import 'package:reading_app/features/nav/home/presentation/page/home_page.dart';
import 'package:reading_app/features/nav/notification/di/notification_binding.dart';
import 'package:reading_app/features/nav/notification/presentation/page/notification_page.dart';
import 'package:reading_app/features/nav/post/di/post_binding.dart';
import 'package:reading_app/features/nav/post/presentation/page/post_page.dart';
import 'package:reading_app/features/nav/profile/di/profile_binding.dart';
import 'package:reading_app/features/nav/profile/presentation/page/profile_page.dart';

class MainController extends GetxController {

  RxInt currentIndex = 0.obs;

  final pages = <String>['/home', '/explore', '/post', '/notify', '/profile'];
  
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
      case '/post':
        return GetPageRoute(
          settings: settings,
          page: () => const PostPage(),
          binding: PostBinding(),
          transition: Transition.fadeIn,
        );
      case '/notify':
        return GetPageRoute(
          settings: settings,
          page: () => const NotificationPage(),
          binding: NotificationBinding(),
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
    Get.offAndToNamed(pages[index], id: 10);
  }
}
