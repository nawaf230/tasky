import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';

class AchievedTasksWidget extends StatelessWidget {
  const AchievedTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksController>(
      builder: (BuildContext context, TasksController controller, Widget? child) {
        controller.init();
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppSizes.w16),
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
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Achieved Tasks",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  SizedBox(height: AppSizes.h4),
                  Text(
                    "${controller.totalDoneTasks} Out of ${controller.totalTasks} Done",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: -pi / 2,
                    child: SizedBox(
                      height: AppSizes.h48,
                      width: AppSizes.w48,
                      child: CircularProgressIndicator(
                        value: controller.percent,
                        backgroundColor: const Color(0xFF6D6D6D),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF15B86C),
                        ),
                        strokeWidth: 4,
                      ),
                    ),
                  ),
                  Text(
                    "${(controller.percent * 100).toInt()}%",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
