import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/dark_theme.dart';
import 'package:tasky/core/theme/light_theme.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/Navigation/main_screen.dart';
import 'package:tasky/features/welcome/welcome_screen.dart';

// Default value of Theme
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesManager().init();
  ThemeController().init();
  String? username = PreferencesManager().getString("username");
  runApp(MyApp(username: username));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this._username});

  final String? _username;

  @override
  Widget build(BuildContext context) {
    // this widget can be Rebuild in this code I return in this method
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeNotifier,
      builder: (BuildContext context, ThemeMode themeMode, Widget? child) {
        return MaterialApp(
          title: 'Tasky',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          debugShowCheckedModeBanner: false,
          home: SafeArea(
            child: _username == null ? WelcomeScreen() : MainScreen(),
          ),
        );
      },
    );
  }
}
