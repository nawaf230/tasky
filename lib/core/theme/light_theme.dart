import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xFFFFFFFF),
    secondary: Color(0xFF161F1B),
  ),
  scaffoldBackgroundColor: Color(0xFFF6F7F9),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFF6F7F9),
    titleTextStyle: TextStyle(
      fontSize: AppSizes.sp20,
      fontWeight: FontWeight.w400,
      color: Color(0xFF161F1B),
    ),
    iconTheme: IconThemeData(color: Color(0xFF161F1B)),
    centerTitle: true,
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF14A662);
      }
      return Color(0xFFFFFFFF);
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFFFFFCFC);
      }
      return Color(0xFF9E9E9E);
    }),
    trackOutlineColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        Colors.transparent;
      }
      return Color(0xFF9E9E9E);
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      }
      return 2;
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF14A662),
      foregroundColor: Color(0xFFFFFFFF),
      textStyle: TextStyle(
        fontSize: AppSizes.sp14,
        fontWeight: FontWeight.w500,
        color: Color(0xFFFFFFFF),
      ),
      minimumSize: Size.fromHeight(AppSizes.h40),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.black)),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Color(0xFFFFFFFF),
    extendedTextStyle: TextStyle(
      fontSize: AppSizes.sp14,
      fontWeight: FontWeight.w500,
    ),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: AppSizes.sp24,
      fontWeight: FontWeight.w400,
      color: Color(0xFF161F1B),
    ),
    displayMedium: TextStyle(
      fontSize: AppSizes.sp28,
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
    ),
    displayLarge: TextStyle(
      fontSize: AppSizes.sp32,
      fontWeight: FontWeight.w400,
      color: Color(0xFF161F1B),
    ),
    titleSmall: TextStyle(
      fontSize: AppSizes.sp14,
      fontWeight: FontWeight.w400,
      color: Color(0xFF3A4640),
    ),
    titleMedium: TextStyle(
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF161F1B),
    ),
    titleLarge: TextStyle(
      fontSize: AppSizes.sp16,
      color: Color(0xFF6A6A6A),
      decoration: TextDecoration.lineThrough,
      decorationColor: Color(0xFF6A6A6A),
    ),
    labelSmall: TextStyle(
      fontSize: AppSizes.sp20,
      fontWeight: FontWeight.w400,
      color: Color(0xFF161F1B),
    ),
    labelMedium: TextStyle(
      color: Color(0xFF000000),
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(),
  ),

  inputDecorationTheme: InputDecorationThemeData(
    hintStyle: TextStyle(
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF9E9E9E),
    ),
    // To change the background color.
    filled: true,
    fillColor: Color(0xFFFFFFFF),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Color(0xFFC62828), width: 0.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide(color: Color(0xFFC62828), width: 1),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    side: BorderSide(width: 2, color: Color(0xFFD1DAD6)),
  ),
  iconTheme: IconThemeData(color: Color(0xFF161F1B)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF161F1B),
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xFFD1DAD6), thickness: 1),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.teal,
    selectionColor: Colors.teal.withValues(alpha: 0.35),
    selectionHandleColor: Colors.teal,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFFF6F7F9),
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xFF3A4640),
    selectedItemColor: Color(0xFF15B86C),
    selectedLabelStyle: TextStyle(
      fontSize: AppSizes.sp12,
      fontWeight: FontWeight.w500,
      color: Color(0xFF15B86C),
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: AppSizes.sp12,
      fontWeight: FontWeight.w600,
    ),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFFF6F7F9),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 16,
    shadowColor: Color(0xFF15B86C),
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(
        fontSize: AppSizes.sp14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF000000),
      ),
    ),
  ),
);
