import 'package:flutter/material.dart';
import 'package:tasky/core/datasource/local_data/file_storage_manager.dart';
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

  TasksController() {
    init();
  }

  Future<void> init() async {
    await _loadTasks();
  }

  Future<void> _loadTasks() async {
    isLoading = true;
    // notifyListeners();

    final taskData = await FileStorageManager().loadTasks();

    tasks = taskData.map((element) => TaskModel.formJson(element)).toList();

    _loadData();
    _calculatePercent();

    isLoading = false;
    notifyListeners();
  }

  void doneTask(bool? value, int id) async {
    final int index = tasks.indexWhere((element) => element.id == id);

    tasks[index].isDone = value ?? false;

    _loadData();
    _calculatePercent();

    final updateTask = tasks.map((e) => e.toJson()).toList();

    await FileStorageManager().saveTasks(updateTask);

    notifyListeners();
  }

  void deleteTask(int? id) async {
    if (id == null) return;

    // Now tasks ready
    // Here I remove the target element.
    tasks.removeWhere((element) => element.id == id);

    _loadData();
    _calculatePercent();

    final updatedTask = tasks.map((e) => e.toJson()).toList();
    await FileStorageManager().saveTasks(updatedTask);

    notifyListeners();
  }

  void _calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((element) => element.isDone).length;
    // calc the average
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;

    notifyListeners();
  }

  // This method calc the todoTasks ,completeTasks and highPriorityTasks.
  void _loadData() {
    todoTasks = tasks.where((element) => !element.isDone).toList();
    completeTasks = tasks.where((element) => element.isDone).toList();
    highPriorityTasks = tasks.reversed
        .where((element) => element.isHighPriority)
        .toList();
  }
}
