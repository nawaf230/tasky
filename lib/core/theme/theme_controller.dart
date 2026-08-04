import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';

class ThemeController {
  // This is Object
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );

  // This init refers to the initialization
  void init() {
    bool result = PreferencesManager().getBool(StorageKey.theme) ?? true;
    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  // Toggle Theme When I press the switch button then I store the final value in SharedPreferences
  // The object in this Function is store a new value in SharedPreferences.
  static void toggleTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PreferencesManager().setBool(StorageKey.theme, false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PreferencesManager().setBool(StorageKey.theme, true);
    }
  }

  static bool isDark() => themeNotifier.value == ThemeMode.dark;
}
