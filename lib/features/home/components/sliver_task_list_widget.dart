import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/features/home/home_controller.dart';
import 'package:tasky/core/components/task_item_widget.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({super.key, this.emptyMessage});
  // Call Blak Function

  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, controller, Widget? child) {
        final tasks = controller.tasks;
        return controller.isLoading
            ? SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(color: Color(0xFFFFFCFC)),
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
                    return SizedBox(height: 8);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return TaskItemWidget(
                      model: tasks[index],
                      onChanged: (bool? value) =>
                          controller.doneTask(value, index),
                      onDelete: (int? id) => controller.deleteTask(id),
                      onEdit: () => controller.loadTask(),
                    );
                  },
                ),
              );
      },
    );
  }
}
