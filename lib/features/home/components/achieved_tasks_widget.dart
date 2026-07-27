import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasky/core/theme/theme_controller.dart';

class AchievedTasksWidget extends StatelessWidget {
  const AchievedTasksWidget({
    super.key,
    required this.totalTasks,
    required this.totalDoneTasks,
    required this.percent,
  });

  final int totalTasks;
  final int totalDoneTasks;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
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
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Achieved Tasks",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(width: 4),
              Text(
                "$totalDoneTasks Out of $totalTasks Done",
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
                  height: 48,
                  width: 48,
                  child: CircularProgressIndicator(
                    value: percent,
                    backgroundColor: Color(0xFF6D6D6D),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF15B86C),
                    ),
                    strokeWidth: 4,
                  ),
                ),
              ),
              Text(
                "${(percent * 100).toInt()}%",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
