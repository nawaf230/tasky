import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/components/task_item_widget.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    this.emptyMessage,
    required this.onDelete,
    required this.onEdit,
  });
  final List<TaskModel> tasks;
  // Call Blak Function
  final void Function(bool?, int) onTap;
  final void Function(int?) onDelete;
  final void Function() onEdit;

  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
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
                  onChanged: (bool? value) => onTap(value, index),
                  onDelete: (int? id) => onDelete(id),
                  onEdit: () => onEdit(),
                );
              },
            ),
          );
  }
}
