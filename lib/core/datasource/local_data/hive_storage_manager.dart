import 'package:hive_ce_flutter/adapters.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/models/task_model.dart';

// This class as a Single Ton.
class HiveStorageManager {
  static final HiveStorageManager _internal = HiveStorageManager._();

  HiveStorageManager._();

  factory HiveStorageManager() {
    return _internal;
  }

  late Box<TaskModel> _taskBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskModelAdapter());

    _taskBox = await Hive.openBox<TaskModel>(StorageKey.tasks);
  }

  Future<void> saveTasks(List<TaskModel> tasks) async {
    await _taskBox.clear();
    await _taskBox.addAll(tasks);
  }

  List<TaskModel> loadTasks() {
    return _taskBox.values.toList();
  }

  Future<void> clear() async {
    await _taskBox.clear();
  }
}
