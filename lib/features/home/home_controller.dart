import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';

class HomeController extends ChangeNotifier {
  // In this List I store all Tasks
  List<TaskModel> tasks = [];
  bool isLoading = true;
  String? username;
  String? motivationQuote;
  String? userImagePath;
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percent = 0;

  void init() {
    loadData();
    loadTask();
  }

  void loadData() async {
    if (username == null || motivationQuote == null) {
      username = PreferencesManager().getString(StorageKey.username);
      motivationQuote = PreferencesManager().getString(
        StorageKey.motivationQuote,
      );
      userImagePath = PreferencesManager().getString(StorageKey.userImage);
    }

    notifyListeners();
  }

  // imp think in this Function is load a tasks and Store in tasks.
  void loadTask() async {
    // After Decode the value type is List<Map<String, dynamic>>
    final String? finalTask = PreferencesManager().getString(StorageKey.tasks);

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      // List<Map<String, dynamic>>

      tasks = taskAfterDecode
          .map((element) => TaskModel.formJson(element))
          .toList();

      calculatePercent();
      // List of TaskModel
    }

    isLoading = false;

    notifyListeners();
  }

  void calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((element) => element.isDone).length;
    // calc the avrg
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;

    notifyListeners();
  }

  void doneTask(bool? value, int index) async {
    // Edit in List tasks and save the value changed (isDone) in the List
    tasks[index].isDone = value ?? false;
    calculatePercent();

    // Convert a tasks of TaskModel into List of Map<String, dynamic>
    final updatedTask = tasks.map((e) => e.toJson()).toList();
    await PreferencesManager().setString(
      StorageKey.tasks,
      jsonEncode(updatedTask),
    );

    notifyListeners();
  }

  void deleteTask(int? id) async {
    if (id == null) return;

    tasks.removeWhere((element) => element.id == id);
    calculatePercent();

    // Convert a tasks of TaskModel into List of Map<String, dynamic>
    final updatedTask = tasks.map((e) => e.toJson()).toList();
    await PreferencesManager().setString(
      StorageKey.tasks,
      jsonEncode(updatedTask),
    );

    notifyListeners();
  }
}
