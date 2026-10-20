import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_check_box.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';
import 'package:tasky/features/tasks/high_priority_screen.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (BuildContext context, TasksController controller, Widget? child) {
        final tasksList = controller.tasks;
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppSizes.r20),
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
                  padding: EdgeInsets.all(AppSizes.w8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppSizes.w8),
                        child: Text(
                          "High Priority Tasks",
                          style: TextStyle(
                            fontSize: AppSizes.sp14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF15B86C),
                          ),
                        ),
                      ),

                      SizedBox(height: AppSizes.h8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            tasksList
                                    .where((element) => element.isHighPriority)
                                    .length >
                                4
                            ? 4
                            : tasksList
                                  .where((element) => element.isHighPriority)
                                  .length,
                        itemBuilder: (context, index) {
                          // This List I reversed main List and store the data isHighPriority in task
                          final task = tasksList.reversed
                              .where((element) => element.isHighPriority)
                              .toList()[index];
                          return Row(
                            children: [
                              CustomCheckBox(
                                value: task.isDone,
                                onChanged: (bool? value) {
                                  tasksList.indexWhere(
                                    (element) => element.id == task.id,
                                  );
                                  controller.doneTask(value, task.id);
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
                    MaterialPageRoute(
                      builder: (context) => HighPriorityScreen(),
                    ),
                  );
                  await controller.init();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppSizes.h16,
                    horizontal: AppSizes.w12,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        alignment: Alignment.bottomRight,
                        width: AppSizes.w40,
                        height: AppSizes.h40,
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
                        width: AppSizes.w24,
                        height: AppSizes.h24,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
