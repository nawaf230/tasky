import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/components/task_list_widget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  // Here I filter the Data then I show in this screen
  List<TaskModel> todoTasks = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  void _loadTask() async {
    setState(() {
      isLoading = true;
    });

    final finalTask = PreferencesManager().getString(StorageKey.tasks);

    if (finalTask != null) {
      final taskAfterDecode =
          jsonDecode(finalTask) as List<dynamic>; // List<Map<String, dynamic>>

      setState(() {
        // Here I store the initial value in todoTasks, the return value is List of TaskModel.
        todoTasks = taskAfterDecode
            .map((element) => TaskModel.formJson(element))
            .where((element) => !element.isDone)
            .toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _deleteTask(int? id) async {
    List<TaskModel> tasks = [];

    if (id == null) return;
    final finalTask = PreferencesManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode =
          jsonDecode(finalTask) as List<dynamic>; // List<Map<String, dynamic>>
      //  Here I store the value of all tasks.
      tasks = taskAfterDecode
          .map((element) => TaskModel.formJson(element))
          .toList();
      tasks.removeWhere((element) => element.id == id);

      setState(() {
        todoTasks.removeWhere((element) => element.id == id);
      });

      final updatedTask = tasks.map((e) => e.toJson()).toList();
      PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "To Do Tasks",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(color: Color(0xFFFFFCFC)),
                  )
                : TaskListWidget(
                    tasks: todoTasks,
                    emptyMessage: "Finshed all tasks",
                    onTap: (bool? value, int index) async {
                      setState(() {
                        todoTasks[index].isDone = value ?? false;
                      });
                      final String? allData = PreferencesManager().getString(
                        StorageKey.tasks,
                      );

                      if (allData != null) {
                        //  allDataList : Here I Update the Data then I store in Shared Preferences
                        final List<TaskModel> allDataList =
                            // List of json
                            (jsonDecode(allData) as List)
                                .map((e) => TaskModel.formJson(e))
                                .toList();

                        final newIndex = allDataList.indexWhere(
                          (element) => element.id == todoTasks[index].id,
                        );

                        allDataList[newIndex] = todoTasks[index];
                        await PreferencesManager().setString(
                          StorageKey.tasks,
                          jsonEncode(allDataList),
                        );
                        // print("====================$allDataList");
                        _loadTask();
                      }
                    },
                    onDelete: (id) => _deleteTask(id),
                    onEdit: () => _loadTask(),
                  ),
          ),
        ),
      ],
    );
  }
}
