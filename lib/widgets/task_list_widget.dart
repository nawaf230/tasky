import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_item_widget.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
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
        ? Align(
            alignment: Alignment.center,
            child: Text(
              emptyMessage ?? "No Tasks Found",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          )
        : ListView.separated(
            // loaded all element of List in the same time
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(bottom: 65),
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
          );
  }
}
