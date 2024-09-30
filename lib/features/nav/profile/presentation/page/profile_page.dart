import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/core/ui/widgets/customs/button/button_normal.dart';
import 'package:reading_app/features/nav/profile/presentation/controller/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ButtonNormal(
          onTap: () {
            controller.logout();
          },
          textChild: 'LOGOUT',
        ),
      ),
    );
  }
}
