import 'package:flutter/material.dart';
import 'package:tasky/core/datasource/local_data/file_storage_manager.dart';
import 'package:tasky/models/task_model.dart';

class AddTaskController extends ChangeNotifier {
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  final TextEditingController taskNameController = TextEditingController();
  bool isHighPriority = true;

  void addTask(BuildContext context) async {
    if (key.currentState?.validate() ?? false) {
      List<dynamic> listTasks = await FileStorageManager().loadTasks();

      // model
      final TaskModel model = TaskModel(
        id: listTasks.length + 1,
        taskName: taskNameController.text,
        taskDescription: taskDescriptionController.text,
        isHighPriority: isHighPriority,
      );

      listTasks.add(model.toJson());
      await FileStorageManager().saveTasks(listTasks);

      if (!context.mounted) return;
      Navigator.of(context).pop(true);
    }
  }

  void toggle(bool value) {
    isHighPriority = value;
    notifyListeners();
  }
}
