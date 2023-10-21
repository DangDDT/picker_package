import 'package:flutter/material.dart';

import 'color_schemes.g.dart';

const kTextColorPrimaryLight = Color(0xFF030F2D);

class CoreTheme {
  static final ThemeData _themeDataLight = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    applyElevationOverlayColor: true,
    fontFamily: 'Roboto',
    colorScheme: lightColorScheme,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        color: kTextColorPrimaryLight,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        color: kTextColorPrimaryLight,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        color: kTextColorPrimaryLight,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        color: kTextColorPrimaryLight,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        color: kTextColorPrimaryLight,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        color: kTextColorPrimaryLight,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        color: kTextColorPrimaryLight,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        color: kTextColorPrimaryLight,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        color: kTextColorPrimaryLight,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: kTextColorPrimaryLight,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: kTextColorPrimaryLight,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: kTextColorPrimaryLight,
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 2,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontWeight: FontWeight.bold,
            wordSpacing: 0,
            letterSpacing: 0,
            fontSize: 13,
          ),
        ),
      ),
    ),
  );
  static final ThemeData _themeDataDark = ThemeData(
    brightness: Brightness.dark,
    applyElevationOverlayColor: true,
    fontFamily: 'Roboto',
    colorScheme: darkColorScheme,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        color: kTextColorPrimaryLight,
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        color: kTextColorPrimaryLight,
      ),
      headlineSmall: TextStyle(
        fontSize: 24,
        color: kTextColorPrimaryLight,
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 22,
        color: kTextColorPrimaryLight,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: kTextColorPrimaryLight,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        color: kTextColorPrimaryLight,
      ),
      labelLarge: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: kTextColorPrimaryLight,
      ),
      labelMedium: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: kTextColorPrimaryLight,
      ),
      labelSmall: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        color: kTextColorPrimaryLight,
      ),
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: kTextColorPrimaryLight,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: kTextColorPrimaryLight,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: kTextColorPrimaryLight,
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,

      scrolledUnderElevation: 2,
      centerTitle: true,
      titleTextStyle: TextStyle(
        // color: kTextColorPrimaryLight,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      // foregroundColor: kTextColorPrimaryLight,
      backgroundColor: Colors.white,
    ),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontWeight: FontWeight.bold,
            wordSpacing: 0,
            letterSpacing: 0,
            fontSize: 13,
          ),
        ),
      ),
    ),
  );

  static ThemeData get lightTheme => _themeDataLight;
}
