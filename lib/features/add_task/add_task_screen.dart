import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/features/add_task/controllers/add_task_controller.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddTaskController>(
      create: (_) => AddTaskController(),
      builder: (BuildContext context, _) {
        final AddTaskController controller = context.read<AddTaskController>();
        return Scaffold(
          appBar: AppBar(title: Text("New Task")),
          body: SafeArea(
            child: Form(
              key: controller.key,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.w16,
                  vertical: AppSizes.h8,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      title: "Task Name",
                      controller: controller.taskNameController,
                      hintText: "Finish UI design for login screen",
                      validator: (value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Please Enter Task Name";
                        }
                        return null;
                      },
                      maxLines: 1,
                    ),
                    SizedBox(height: AppSizes.h20),
                    CustomTextFormField(
                      title: "Task Description",
                      controller: controller.taskDescriptionController,
                      hintText:
                          "Finish onboarding UI and hand off to devs by Thursday.",
                      maxLines: 5,
                    ),
                    SizedBox(height: AppSizes.h20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "High Priority",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Consumer<AddTaskController>(
                          builder: (context, controller, child) {
                            return Switch(
                              value: controller.isHighPriority,
                              onChanged: (bool value) {
                                controller.toggle(value);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    Spacer(),
                    ElevatedButton.icon(
                      onPressed: () async {
                        controller.addTask(context);
                      },
                      icon: Icon(Icons.add),
                      label: Text(
                        "Add Task",
                        style: TextStyle(
                          fontSize: AppSizes.sp14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
