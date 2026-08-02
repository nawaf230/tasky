import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/widget/custom_svg_picture.dart';
import 'package:tasky/features/home/home_controller.dart';
import 'package:tasky/features/add_task/add_task_screen.dart';
import 'package:tasky/features/home/components/high_priority_tasks_widget.dart';
import 'package:tasky/features/home/components/achieved_tasks_widget.dart';
import 'package:tasky/features/home/components/sliver_task_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext context) => HomeController()..init(),
      child: Consumer<HomeController>(
        builder: (BuildContext context, controller, Widget? child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    controller.userImagePath != null
                                    ? FileImage(File(controller.userImagePath!))
                                    : null,
                                child: ClipOval(
                                  child: controller.userImagePath == null
                                      ? CustomSvgPicture.withoutColor(
                                          path: "assets/images/person.svg",
                                        )
                                      : null,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.username == null
                                        ? "Good Evening ,"
                                        : "Good Evening ,${controller.username}",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                  Text(
                                    controller.motivationQuote == null
                                        ? "One task at a time. One step closer."
                                        : "${controller.motivationQuote}",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Yuhuu ,Your work Is",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Row(
                            children: [
                              Text(
                                "almost done !",
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              SizedBox(width: 8),
                              CustomSvgPicture.withoutColor(
                                path: "assets/images/waving_hand.svg",
                                width: 32,
                                height: 32,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          AchievedTasksWidget(
                            totalTasks: controller.totalTasks,
                            totalDoneTasks: controller.totalDoneTasks,
                            percent: controller.percent,
                          ),
                          const SizedBox(height: 8),
                          HighPriorityTasksWidget(
                            tasks: controller.tasks,
                            refresh: controller.loadTask,
                            onTap: (value, index) =>
                                controller.doneTask(value, index),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 24.0,
                              bottom: 16,
                            ),
                            child: Text(
                              "My Tasks",
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium!.copyWith(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  controller.isLoading
                      ? SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFFFFFCFC),
                            ),
                          ),
                        )
                      : SliverTaskListWidget(
                          tasks: controller.tasks,
                          emptyMessage:
                              "The are no taske yet... Clike + to add the first task ✍",
                          onTap: (bool? value, int index) =>
                              controller.doneTask(value, index),
                          onDelete: (int? id) => controller.deleteTask(id),
                          onEdit: () => controller.loadTask(),
                        ),
                ],
              ),
            ),
            floatingActionButton: SizedBox(
              height: 44,
              child: FloatingActionButton.extended(
                onPressed: () async {
                  final bool? result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTask()),
                  );
                  print("===========================$result");
                  if (result != null && result) {
                    controller.loadTask();
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                icon: Icon(Icons.add),
                label: Text("Add New Task"),
              ),
            ),
          );
        },
      ),
    );
  }
}
