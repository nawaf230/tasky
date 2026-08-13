import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/datasource/local_data/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';

class AddTaskController extends ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  final TextEditingController taskNameController = TextEditingController();
  bool isHighPriority = true;

  void addTask(BuildContext context) async {
    if (key.currentState?.validate() ?? false) {
      final String? taskJson = PreferencesManager().getString(StorageKey.tasks);

      List<dynamic> listTasks = [];
      if (taskJson != null) {
        listTasks = jsonDecode(taskJson) as List<dynamic>;
      }
      // model
      final TaskModel modle = TaskModel(
        id: listTasks.length + 1,
        taskName: taskNameController.text,
        taskDescription: taskDescriptionController.text,
        isHighPriority: isHighPriority,
      );
      //  convert to json

      listTasks.add(modle.toJson());
      final taskEncode = jsonEncode(listTasks);
      // print("================List Tasks : $listTasks");
      await PreferencesManager().setString(StorageKey.tasks, taskEncode);
      Navigator.of(context).pop(true);
    }
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
