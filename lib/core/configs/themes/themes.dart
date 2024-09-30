import 'package:flutter/material.dart';
import 'package:reading_app/core/configs/themes/app_colors.dart';

class Themes {
  static ThemeData get light {
    return ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.white),
      scaffoldBackgroundColor: AppColors.white,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primaryHover,
        // ignore: deprecated_member_use
        background: AppColors.white,
        error: AppColors.error,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.textNormal),
        bodyMedium: TextStyle(color: AppColors.textNormal),
        titleLarge: TextStyle(color: AppColors.textNormal),
        titleMedium: TextStyle(color: AppColors.textNormal),
        titleSmall: TextStyle(color: AppColors.textNormal),
        headlineLarge: TextStyle(color: AppColors.textNormal),
        headlineMedium: TextStyle(color: AppColors.textNormal),
        headlineSmall: TextStyle(color: AppColors.textNormal),
        labelLarge: TextStyle(color: AppColors.textNormal),
        labelMedium: TextStyle(color: AppColors.textNormal),
        labelSmall: TextStyle(color: AppColors.textNormal),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        // ignore: deprecated_member_use
        fillColor: MaterialStateProperty.all(AppColors.primary),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.black),
      scaffoldBackgroundColor: AppColors.black,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primaryHover,
        // ignore: deprecated_member_use
        background: AppColors.black,
        error: AppColors.error,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.textLight),
        bodyMedium: TextStyle(color: AppColors.textLight),
        titleLarge: TextStyle(color: AppColors.textLight),
        titleMedium: TextStyle(color: AppColors.textLight),
        titleSmall: TextStyle(color: AppColors.textLight),
        headlineLarge: TextStyle(color: AppColors.textLight),
        headlineMedium: TextStyle(color: AppColors.textLight),
        headlineSmall: TextStyle(color: AppColors.textLight),
        labelLarge: TextStyle(color: AppColors.textLight),
        labelMedium: TextStyle(color: AppColors.textLight),
        labelSmall: TextStyle(color: AppColors.textLight),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.grey2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        // ignore: deprecated_member_use
        fillColor: MaterialStateProperty.all(AppColors.primary),
      ),
    );
  }
}
