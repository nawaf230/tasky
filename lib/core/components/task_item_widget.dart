import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/enums/task_item_action_enum.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widget/custom_check_box.dart';
import 'package:tasky/core/widget/custom_text_form_field.dart';
import 'package:tasky/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  TaskItemWidget({
    super.key,
    required this.model,
    required this.onChanged,
    required this.onDelete,
    required this.onEdit,
  });
  final TaskModel model;
  // Call Blak Function
  final void Function(bool?) onChanged;
  // I seand the index in this Function
  final void Function(int?) onDelete;
  final void Function() onEdit;
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController.isDark()
              ? Colors.transparent
              : Color(0xFFD1DAD6),
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          CustomCheckBox(
            value: model.isDone,
            onChanged: (bool? value) => onChanged(value),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.taskName,
                  style: model.isDone
                      ? Theme.of(context).textTheme.titleLarge
                      : Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                ),
                if (model.taskDescription.isNotEmpty)
                  Text(
                    model.taskDescription,
                    style: Theme.of(context).textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
              ],
            ),
          ),
          PopupMenuButton<TaskItemActionEnum>(
            padding: EdgeInsets.all(3),
            icon: Icon(Icons.more_vert),
            iconColor: !ThemeController.isDark()
                ? model.isDone
                      ? Color(0xFF6A6A6A)
                      : Color(0xFF3A4640)
                : model.isDone
                ? Color(0xFFA0A0A0)
                : Color(0xFFC6C6C6),
            onSelected: (value) async {
              switch (value) {
                case TaskItemActionEnum.markAsDone:
                  onChanged(!model.isDone);

                case TaskItemActionEnum.edit:
                  // the value return is ture or null
                  final result = await _showBottomSheet(context, model);
                  if (result ?? false) {
                    onEdit();
                  }

                case TaskItemActionEnum.delete:
                  await _showDialog(context);
              }
            },
            itemBuilder: (context) => [
              // this is Spared opareter
              ...TaskItemActionEnum.values.map(
                (e) => PopupMenuItem(value: e, child: Text(e.name)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<String?> _showDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Task"),
        content: Form(
          key: _key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextFormField(
                controller: controller,
                hintText: "hintText",
                title: "Enter Delete word to delete the target task",
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a Valid value";
                  } else if (value.toLowerCase().trim() != "delete") {
                    return "Enter the valid word";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (_key.currentState!.validate()) {
                onDelete(model.id);
                Navigator.pop(context, controller.text);
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showBottomSheet(BuildContext context, TaskModel modle) {
    final TextEditingController taskNameController = TextEditingController(
      text: modle.taskName,
    );
    final TextEditingController taskDescriptionController =
        TextEditingController(text: modle.taskDescription);
    final key = GlobalKey<FormState>();
    bool isHighPriority = modle.isHighPriority;
    return showModalBottomSheet<bool>(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: MediaQuery.of(context).viewInsets.bottom + 8,
              ),
              child: SafeArea(
                child: Form(
                  key: key,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      CustomTextFormField(
                        title: "Task Name",
                        controller: taskNameController,
                        hintText: "Finish UI design for login screen",
                        validator: (value) {
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
                        controller: taskDescriptionController,
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
                            value: isHighPriority,
                            onChanged: (bool value) {
                              setState(() {
                                isHighPriority = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            40,
                          ),
                        ),
                        onPressed: () async {
                          if (key.currentState?.validate() ?? false) {
                            final String? taskJson = PreferencesManager()
                                .getString(StorageKey.tasks);
                            //  List<Map<String ,dynamic>> || List of Json
                            List<dynamic> listTasks = [];
                            if (taskJson != null) {
                              listTasks = jsonDecode(taskJson) as List<dynamic>;
                            }
                            // The model after edit.
                            final TaskModel newModle = TaskModel(
                              id: modle.id,
                              taskName: taskNameController.text,
                              taskDescription: taskDescriptionController.text,
                              isHighPriority: isHighPriority,
                              isDone: modle.isDone,
                            );

                            final item = listTasks.firstWhere(
                              (element) => element["id"] == modle.id,
                            );
                            final index = listTasks.indexOf(item);
                            listTasks[index] = newModle;

                            //  convert to json
                            print("modle to Json = ${modle.toJson()}");
                            print("=====$listTasks");

                            await PreferencesManager().setString(
                              StorageKey.tasks,
                              jsonEncode(listTasks),
                            );

                            Navigator.of(context).pop(true);
                          }
                        },
                        icon: Icon(Icons.edit),
                        label: Text(
                          "Edit Task",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
