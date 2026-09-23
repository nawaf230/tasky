import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';
import 'package:tasky/core/components/task_list_widget.dart';

class HighPriorityScreen extends StatelessWidget {
  const HighPriorityScreen({super.key});

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
                child: Consumer<TasksController>(
                  builder: (context, TasksController controller, child) {
                    return TaskListWidget(
                      tasks: controller.highPriorityTasks,
                      onTap: (value, index) {
                        controller.doneTask(
                          value,
                          controller.highPriorityTasks[index].id,
                        );
                      },
                      onDelete: (id) {
                        controller.deleteTask(id);
                      },
                      onEdit: () async{
                       await controller.init();
                      },
                    );
                  },
                ),
              ),
      ),
    );
  }
}
