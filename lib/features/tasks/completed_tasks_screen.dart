import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';
import 'package:tasky/core/components/task_list_widget.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TasksController controller = context.read();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text(
            "Completed Tasks",
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: controller.isLoading
                ? Center(
                    child: CircularProgressIndicator(color: Color(0xFFFFFCFC)),
                  )
                : Consumer<TasksController>(
                    builder: (context, TasksController controller, child) {
                      return TaskListWidget(
                        tasks: controller.completeTasks,
                        onTap: (bool? value, int index) async {
                          controller.doneTask(
                            value,
                            controller.completeTasks[index].id,
                          );
                        },
                        onDelete: (id) {
                          controller.deleteTask(id);
                        },
                        onEdit: () {
                          controller.init();
                        },
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}
