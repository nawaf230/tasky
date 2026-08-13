import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/datasource/local_data/preferences_manager.dart';

class HomeController extends ChangeNotifier {
  // In this List I store all Tasks
  String? username;
  String? motivationQuote;
  String? userImagePath;

  void init() {
    loadUserData();
  }

  void loadUserData() async {
    if (username == null || motivationQuote == null) {
      username = PreferencesManager().getString(StorageKey.username);
      motivationQuote = PreferencesManager().getString(
        StorageKey.motivationQuote,
      );
      userImagePath = PreferencesManager().getString(StorageKey.userImage);
    }

    notifyListeners();
  }
}
