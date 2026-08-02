import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/components/task_list_widget.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TaskModel> highPriorityTasks = [];
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
        highPriorityTasks = taskAfterDecode
            .map((element) => TaskModel.formJson(element))
            .toList()
            .reversed
            .where((element) => element.isHighPriority)
            .toList();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _doneTask(bool? value, int index) async {
    setState(() {
      highPriorityTasks[index].isDone = value ?? false;
    });

    final String? allData = PreferencesManager().getString(StorageKey.tasks);
    if (allData != null) {
      //  allDataList : Here I Update the Data then I store in Shared Preferences
      final List<TaskModel> allDataList =
          // List of json
          (jsonDecode(allData) as List<dynamic>)
              .map((e) => TaskModel.formJson(e))
              .toList();

      final newIndex = allDataList.indexWhere(
        (element) => element.id == highPriorityTasks[index].id,
      );

      allDataList[newIndex] = highPriorityTasks[index];
      await PreferencesManager().setString(StorageKey.tasks, jsonEncode(allDataList));
    }
    return;
  }

  void _deleteTask(int? id) async {
    // imp : It store all tasks first, then store tasks after deleted target task
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
        highPriorityTasks.removeWhere((element) => element.id == id);
      });

      final updatedTask = tasks.map((e) => e.toJson()).toList();
      PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "High Priority Tasks",
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ),
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: Color(0xFFFFFCFC)))
            : Padding(
                padding: const EdgeInsets.all(16),
                child: TaskListWidget(
                  tasks: highPriorityTasks,
                  onTap: (value, index) {
                    _doneTask(value, index);
                  },
                  onDelete: (id) => _deleteTask(id),
                  onEdit: () => _loadTask(),
                ),
              ),
      ),
    );
  }
}
