import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widget/custom_text_form_field.dart';
import 'package:tasky/models/task_model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _taskDescriptionController =
      TextEditingController();

  final TextEditingController _taskNameController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool _isHighPriority = true;

  @override
  void dispose() {
    super.dispose();
    _taskNameController.dispose();
    _taskDescriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("New Task")),
      body: SafeArea(
        child: Form(
          key: _key,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  title: "Task Name",
                  controller: _taskNameController,
                  hintText: "Finish UI design for login screen",
                  validator: (value) {
                    print(value);
                    if (value?.trim().isEmpty ?? true) {
                      return "Please Enter Task Name";
                    }
                    return null;
                  },
                  maxLines: 1,
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  title: "Task Description",
                  controller: _taskDescriptionController,
                  hintText:
                      "Finish onboarding UI and hand off to devs by Thursday.",
                  maxLines: 5,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "High Priority",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Switch(
                      value: _isHighPriority,
                      onChanged: (bool value) {
                        setState(() {
                          _isHighPriority = value;
                        });
                      },
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width, 40),
                  ),
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      final String? taskJson = PreferencesManager().getString(
                        StorageKey.tasks,
                      );

                      List<dynamic> listTasks = [];
                      if (taskJson != null) {
                        listTasks = jsonDecode(taskJson) as List<dynamic>;
                      }
                      // model
                      final TaskModel modle = TaskModel(
                        id: listTasks.length + 1,
                        taskName: _taskNameController.text,
                        taskDescription: _taskDescriptionController.text,
                        isHighPriority: _isHighPriority,
                      );
                      //  convert to json
                      print("modle to Json = ${modle.toJson()}");
                      print("=====$listTasks");
                      listTasks.add(modle.toJson());
                      final taskEncode = jsonEncode(listTasks);
                      // print("================List Tasks : $listTasks");
                      await PreferencesManager().setString(StorageKey.tasks, taskEncode);
                      Navigator.of(context).pop(true);
                    }
                  },
                  icon: Icon(Icons.add),
                  label: Text(
                    "Add Task",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
