import 'package:flutter/material.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widget/custom_check_box.dart';
import 'package:tasky/core/widget/custom_svg_picture.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/screenes/high_priority_screen.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.refresh,
  });

  final List<TaskModel> tasks;
  final void Function(bool? value, int index) onTap;
  // In this Function I store _loadTask.
  final void Function() refresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "High Priority Tasks",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF15B86C),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        tasks
                                .where((element) => element.isHighPriority)
                                .length >
                            4
                        ? 4
                        : tasks
                              .where((element) => element.isHighPriority)
                              .length,
                    itemBuilder: (context, index) {
                      // This List I reversed main List and store the data isHighPriority in task
                      final task = tasks.reversed
                          .where((element) => element.isHighPriority)
                          .toList()[index];
                      return Row(
                        children: [
                          CustomCheckBox(
                            value: task.isDone,
                            onChanged: (bool? value) {
                              final index = tasks.indexWhere(
                                (element) => element.id == task.id,
                              );
                              onTap(value, index);
                            },
                          ),
                          Expanded(
                            child: Text(
                              task.taskName,
                              style: task.isDone
                                  ? Theme.of(context).textTheme.titleLarge
                                  : Theme.of(context).textTheme.titleMedium,

                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HighPriorityScreen()),
              );
              refresh();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ThemeController.isDark()
                            ? Color(0xFF6E6E6E)
                            : Color(0xFFD1DAD6),
                      ),
                    ),
                  ),
                  CustomSvgPicture(
                    path: "assets/images/arrow_up_right.svg",
                    colorFilter: ThemeController.isDark()
                        ? Color(0xFFC6C6C6)
                        : Color(0xFF3A4640),
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
