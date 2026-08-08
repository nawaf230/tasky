import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/components/task_item_widget.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({super.key, this.emptyMessage});
  // Call Blak Function

  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder:
          (BuildContext context, TasksController controller, Widget? child) {
            final tasks = controller.tasks;
            return controller.isLoading
                ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFFFCFC),
                      ),
                    ),
                  )
                : tasks.isEmpty
                ? SliverToBoxAdapter(
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          emptyMessage ?? "No Tasks Found",
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: EdgeInsets.only(bottom: 80),
                    sliver: SliverList.separated(
                      itemCount: tasks.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Gap(8);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return TaskItemWidget(
                          model: tasks[index],
                          onChanged: (bool? value) =>
                              controller.doneTask(value, index),
                          onDelete: (int? id) => controller.deleteTask(id),
                          onEdit: () => controller.init(),
                        );
                      },
                    ),
                  );
          },
    );
  }
}
