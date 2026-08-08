import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
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
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    const Gap(20),
                    CustomTextFormField(
                      title: "Task Description",
                      controller: controller.taskDescriptionController,
                      hintText:
                          "Finish onboarding UI and hand off to devs by Thursday.",
                      maxLines: 5,
                    ),
                    const Gap(20),
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
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 40),
                      ),
                      onPressed: () async {
                        controller.addTask(context);
                      },
                      icon: Icon(Icons.add),
                      label: Text(
                        "Add Task",
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
          ),
        );
      },
    );
  }
}
