<<<<<<< HEAD
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.light,

    scaffoldBackgroundColor: AppColors.lightBackground,

    colorScheme: ColorScheme.light(
      primary: AppColors.electricAqua,
      secondary: AppColors.electricAqua,
      surface: AppColors.lightCard,
      onPrimary: AppColors.charcoal,
      onSurface: AppColors.lightText,
    ),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.lightBackground,
      foregroundColor: AppColors.charcoal,
    ),

    cardTheme: CardThemeData(
      color: AppColors.lightCard,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.electricAqua,
        foregroundColor: AppColors.charcoal,
        minimumSize: const Size.fromHeight(55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    ),

    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(
      backgroundColor: AppColors.electricAqua,
      foregroundColor: AppColors.charcoal,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.darkBackground,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.electricAqua,
      secondary: AppColors.electricAqua,
      surface: AppColors.darkCard,
      onPrimary: Colors.black,
      onSurface: AppColors.darkText,
    ),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.darkText,
    ),

    cardTheme: CardThemeData(
      color: AppColors.darkCard,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.electricAqua,
        foregroundColor: Colors.black,
        minimumSize: const Size.fromHeight(55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    ),

    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(
      backgroundColor: AppColors.electricAqua,
      foregroundColor: Colors.black,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.charcoalLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
    ),
  );
=======
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.light,

    scaffoldBackgroundColor: AppColors.lightBackground,

    colorScheme: ColorScheme.light(
      primary: AppColors.electricAqua,
      secondary: AppColors.electricAqua,
      surface: AppColors.lightCard,
      onPrimary: AppColors.charcoal,
      onSurface: AppColors.lightText,
    ),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.lightBackground,
      foregroundColor: AppColors.charcoal,
    ),

    cardTheme: CardThemeData(
      color: AppColors.lightCard,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.electricAqua,
        foregroundColor: AppColors.charcoal,
        minimumSize: const Size.fromHeight(55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    ),

    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(
      backgroundColor: AppColors.electricAqua,
      foregroundColor: AppColors.charcoal,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.darkBackground,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.electricAqua,
      secondary: AppColors.electricAqua,
      surface: AppColors.darkCard,
      onPrimary: Colors.black,
      onSurface: AppColors.darkText,
    ),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.darkText,
    ),

    cardTheme: CardThemeData(
      color: AppColors.darkCard,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.electricAqua,
        foregroundColor: Colors.black,
        minimumSize: const Size.fromHeight(55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    ),

    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(
      backgroundColor: AppColors.electricAqua,
      foregroundColor: Colors.black,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.charcoalLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
    ),
  );
>>>>>>> 656d780915e823b4356a161e248a42e061f060ed
}