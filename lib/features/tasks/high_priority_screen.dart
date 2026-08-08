import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';
import 'package:tasky/core/components/task_list_widget.dart';

class HighPriorityScreen extends StatelessWidget {
  const HighPriorityScreen({super.key});

  // void _deleteTask(int? id) async {
  //   // imp : It store all tasks first, then store tasks after deleted target task
  //   List<TaskModel> tasks = [];

  //   if (id == null) return;
  //   final finalTask = PreferencesManager().getString(StorageKey.tasks);
  //   if (finalTask != null) {
  //     final taskAfterDecode =
  //         jsonDecode(finalTask) as List<dynamic>; // List<Map<String, dynamic>>
  //     //  Here I store the value of all tasks.
  //     tasks = taskAfterDecode
  //         .map((element) => TaskModel.formJson(element))
  //         .toList();
  //     tasks.removeWhere((element) => element.id == id);

  //     setState(() {
  //       highPriorityTasks.removeWhere((element) => element.id == id);
  //     });

  //     final updatedTask = tasks.map((e) => e.toJson()).toList();
  //     PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
  //   }
  //   return;
  // }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<TasksController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "High Priority Tasks",
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
      body: SafeArea(
        child: controller.isLoading
            ? Center(child: CircularProgressIndicator(color: Color(0xFFFFFCFC)))
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Consumer(
                  builder: (context, value, child) {
                    return TaskListWidget(
                      tasks: controller.highPriorityTasks,
                      onTap: (value, index) {
                        controller.doneCompleteTask(value, index);
                      },
                      onDelete: (id) {
                        // _deleteTask(id);
                      },
                      onEdit: () {
                        controller.init();
                      },
                    );
                  },
                ),
              ),
      ),
    );
  }
}
