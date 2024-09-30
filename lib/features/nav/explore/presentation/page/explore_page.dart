

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reading_app/features/nav/explore/presentation/controller/explore_controller.dart';

class ExplorePage extends GetView<ExploreController>{
  const ExplorePage({super.key});


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("This is explore page"),),
    );
  }

}