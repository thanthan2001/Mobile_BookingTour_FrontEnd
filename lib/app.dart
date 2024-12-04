import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:reading_app/app_binding.dart';
import 'package:reading_app/core/configs/themes/themes.dart';
import 'package:reading_app/core/lang/translation_service.dart';
import 'package:reading_app/core/routes/pages.dart';
import 'package:reading_app/core/utils/behavior.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Pages.initial,
      scrollBehavior: MyBehavior(),
      getPages: Pages.routes,
      initialBinding: AppBinding(),
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      theme: Themes.light,
      darkTheme: Themes.dark, // Apply the dark theme
      // themeMode: ThemeMode.system, // Use system theme mode (light or dark)
    );
  }
}
