import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/constants.dart';

// Create light theme
final ThemeData lightTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: lightBackgroundColor,
  textTheme: Typography.englishLike2018
      .apply(
        fontSizeFactor: 1.sp,
      )
      .copyWith(
        bodyLarge: const TextStyle(color: lightTextColor),
        bodyMedium: const TextStyle(color: lightTextColor),
        bodySmall: const TextStyle(color: lightTextColor),
      ),
  appBarTheme: const AppBarTheme(
    color: primaryColor,
    titleTextStyle: TextStyle(color: lightBackgroundColor, fontSize: 20),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(primaryAccentColor),
      foregroundColor: MaterialStateProperty.all(lightBackgroundColor),
    ),
  ),
  colorScheme: const ColorScheme.light(
    primary: primaryColor,
    secondary: primaryAccentColor,
    background: lightBackgroundColor,
    onPrimary: lightBackgroundColor,
    onSecondary: lightTextColor,
    onBackground: lightTextColor,
  ),
);

// Create dark theme
final ThemeData darkTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: darkBackgroundColor,
  textTheme: Typography.englishLike2018
      .apply(
        fontSizeFactor: 1.sp,
      )
      .copyWith(
        bodyLarge: const TextStyle(color: darkTextColor),
        bodyMedium: const TextStyle(color: darkTextColor),
        bodySmall: const TextStyle(color: darkTextColor),
      ),
  appBarTheme: const AppBarTheme(
    color: primaryColor,
    titleTextStyle: TextStyle(color: darkBackgroundColor, fontSize: 20),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(primaryAccentColor),
      foregroundColor: MaterialStateProperty.all(darkBackgroundColor),
    ),
  ),
  colorScheme: const ColorScheme.dark(
    primary: primaryColor,
    secondary: primaryAccentColor,
    background: darkBackgroundColor,
    onPrimary: darkBackgroundColor,
    onSecondary: darkTextColor,
    onBackground: darkTextColor,
  ),
);
