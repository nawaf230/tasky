import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';

class TasksController extends ChangeNotifier {
  bool isLoading = false;

  List<TaskModel> tasks = [];
  List<TaskModel> completeTasks = [];
  List<TaskModel> todoTasks = [];
  List<TaskModel> highPriorityTasks = [];

  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percent = 0;

  void init() {
    _loadTasks();
    notifyListeners();
  }

  void _loadTasks() {
    // After Decode the value type is List<Map<String, dynamic>>
    final String? finalTask = PreferencesManager().getString(StorageKey.tasks);

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      // List<Map<String, dynamic>>

      tasks = taskAfterDecode
          .map((element) => TaskModel.formJson(element))
          .toList();

      todoTasks = tasks.where((element) => !element.isDone).toList();

      completeTasks = tasks.where((element) => element.isDone).toList();

      highPriorityTasks = tasks.reversed
          .where((element) => element.isHighPriority)
          .toList();
    }

    isLoading = false;
  }

  void doneTask(bool? value, int index) async {
    tasks[index].isDone = value ?? false;
    calculatePercent();
    final updatetTask = tasks.map((e) => e.toJson()).toList();
    await PreferencesManager().setString(
      StorageKey.tasks,
      jsonEncode(updatetTask),
    );

    init();
  }

  void doneTodoTask(bool? value, int index) async {
    todoTasks[index].isDone = value ?? false;
    final String? allData = PreferencesManager().getString(StorageKey.tasks);
    calculatePercent();

    if (allData != null) {
      //  allDataList : Here I Update the Data then I store in Sahred Preferences
      final List<TaskModel> allDataList =
          // List of json and the final resut is List of TaskModel.
          (jsonDecode(allData) as List<dynamic>)
              .map((e) => TaskModel.formJson(e))
              .toList();

      final newIndex = allDataList.indexWhere(
        (element) => element.id == todoTasks[index].id,
      );

      // Here I update the value of tasks.
      allDataList[newIndex] = todoTasks[index];
      await PreferencesManager().setString(
        StorageKey.tasks,
        jsonEncode(allDataList),
      );
      init();
    }
  }

  void doneCompleteTask(bool? value, int index) async {
    completeTasks[index].isDone = value ?? false;
    final String? allData = PreferencesManager().getString(StorageKey.tasks);
    calculatePercent();

    if (allData != null) {
      //  allDataList : Here I Update the Data then I store in Sahred Preferences
      final List<TaskModel> allDataList =
          // List of json and the final resut is List of TaskModel.
          (jsonDecode(allData) as List<dynamic>)
              .map((e) => TaskModel.formJson(e))
              .toList();

      final newIndex = allDataList.indexWhere(
        (element) => element.id == completeTasks[index].id,
      );

      // Here I update the value of tasks.
      allDataList[newIndex] = completeTasks[index];
      await PreferencesManager().setString(
        StorageKey.tasks,
        jsonEncode(allDataList),
      );
      init();
    }
  }

  void doneHighPriorityTask(bool? value, int index) async {
    highPriorityTasks[index].isDone = value ?? false;
    final String? allData = PreferencesManager().getString(StorageKey.tasks);
    calculatePercent();

    if (allData != null) {
      //  allDataList : Here I Update the Data then I store in Sahred Preferences
      final List<TaskModel> allDataList =
          // List of json and the final resut is List of TaskModel.
          (jsonDecode(allData) as List<dynamic>)
              .map((e) => TaskModel.formJson(e))
              .toList();

      final newIndex = allDataList.indexWhere(
        (element) => element.id == highPriorityTasks[index].id,
      );

      // Here I update the value of tasks.
      allDataList[newIndex] = highPriorityTasks[index];
      await PreferencesManager().setString(
        StorageKey.tasks,
        jsonEncode(allDataList),
      );
      init();
    }
  }

  void deleteTask(int? id) async {
    if (id == null) return;

    // Now tasks ready
    // Here I remove the targte element.
    tasks.removeWhere((element) => element.id == id);
    todoTasks.removeWhere((element) => element.id == id);
    completeTasks.removeWhere((element) => element.id == id);
    highPriorityTasks.removeWhere((element) => element.id == id);
    calculatePercent();

    final updatedTask = tasks.map((e) => e.toJson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));

    notifyListeners();
  }

  void calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((element) => element.isDone).length;
    // calc the average
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;

    notifyListeners();
  }
}
