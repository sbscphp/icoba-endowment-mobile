import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../color_path.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(),
    textTheme: TextTheme(
      bodySmall: AppTypography.bodySmall,
      bodyMedium: AppTypography.bodyMedium,
      bodyLarge: AppTypography.bodyLarge,
      titleSmall: AppTypography.titleSmall,
      titleMedium: AppTypography.titleMedium,
      titleLarge: AppTypography.titleLarge,
    ),
    scaffoldBackgroundColor: ColorPath.white,
    // appBarTheme: const AppBarTheme(
    //   //systemOverlayStyle: SystemUiOverlayStyle.light,
    //   systemOverlayStyle: SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     statusBarIconBrightness: Brightness.light,
    //     statusBarBrightness: Brightness.dark,
    //   ),
    // ),
    fontFamily: 'Inter',
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(),
    textTheme: TextTheme(
      bodySmall: AppTypography.bodySmall,
      bodyMedium: AppTypography.bodyMedium,
      bodyLarge: AppTypography.bodyLarge,
      titleSmall: AppTypography.titleSmall,
      titleMedium: AppTypography.titleMedium,
      titleLarge: AppTypography.titleLarge,
    ),
    fontFamily: 'Inter',
    useMaterial3: true,
  );

  //update status bar colors dynamically
  static void updateStatusBarBrightness({required ThemeMode themeMode}) {
    if (themeMode == ThemeMode.dark) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      );
    } else {
      // systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
      //   statusBarColor: Colors.transparent,
      // ),
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      );
    }
  }
}
