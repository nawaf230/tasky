import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_sizes.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF181818),
  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0xFF282828),
    secondary: Color(0xFFFFFCFC),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF181818),
    titleTextStyle: TextStyle(
      fontSize: AppSizes.sp20,
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
    ),
    iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),
    centerTitle: true,
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xFF15B86C);
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
      backgroundColor: Color(0xFF15B86C),
      foregroundColor: Color(0xFFFFFCFC),
      textStyle: TextStyle(
        fontSize: AppSizes.sp14,
        fontWeight: FontWeight.w500,
      ),
      minimumSize: Size.fromHeight(AppSizes.h40),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(Color(0xFFFFFFFF)),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF15B86C),
    foregroundColor: Color(0xFFFFFCFC),
    extendedTextStyle: TextStyle(
      fontSize: AppSizes.sp14,
      fontWeight: FontWeight.w500,
    ),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      fontSize: AppSizes.sp24,
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
    ),
    displayMedium: TextStyle(
      fontSize: AppSizes.sp28,
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFFFF),
    ),
    displayLarge: TextStyle(
      fontSize: AppSizes.sp32,
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
    ),
    titleSmall: TextStyle(
      fontSize: AppSizes.sp14,
      fontWeight: FontWeight.w400,
      color: Color(0xFFC6C6C6),
    ),

    titleMedium: TextStyle(
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
    ),
    titleLarge: TextStyle(
      fontSize: AppSizes.sp16,
      color: Color(0xFFA0A0A0),
      decoration: TextDecoration.lineThrough,
    ),
    labelMedium: TextStyle(
      color: Color(0xFFFFFCFC),
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      decorationColor: Color(0xFFA0A0A0),
    ),
    labelSmall: TextStyle(
      fontSize: AppSizes.sp20,
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
    ),
  ),
  inputDecorationTheme: InputDecorationThemeData(
    hintStyle: TextStyle(
      fontSize: AppSizes.sp16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF6D6D6D),
    ),
    filled: true,
    fillColor: Color(0xFF282828),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSizes.r16),
      borderSide: BorderSide.none,
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
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.r4),
    ),
    side: BorderSide(width: 2, color: Color(0xFF6E6E6E)),
  ),
  iconTheme: IconThemeData(color: Color(0xFFFFFCFC)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: Color(0xFFFFFCFC),
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xFF6E6E6E), thickness: 1),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.tealAccent,
    selectionColor: Colors.teal.withValues(alpha: 0.45),
    selectionHandleColor: Colors.tealAccent,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF181818),
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Color(0xFFC6C6C6),
    selectedItemColor: Color(0xFF15B86C),
    selectedLabelStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
    unselectedLabelStyle: TextStyle(
      fontSize: AppSizes.sp12,
      fontWeight: FontWeight.w600,
    ),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    color: Color(0xFF181818),
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Color(0xFF15B86C)),
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 12,
    shadowColor: Color(0xFF15B86C),
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(
        fontSize: AppSizes.sp14,
        fontWeight: FontWeight.w500,
        color: Color(0xFFFFFFFF),
      ),
    ),
  ),
);
