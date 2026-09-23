import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/app_sizes.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/features/home/controllers/home_controller.dart';
import 'package:tasky/features/add_task/add_task_screen.dart';
import 'package:tasky/features/home/components/high_priority_tasks_widget.dart';
import 'package:tasky/features/home/components/achieved_tasks_widget.dart';
import 'package:tasky/features/home/components/sliver_task_list_widget.dart';
import 'package:tasky/features/tasks/controllers/tasks_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (BuildContext _) => HomeController()..init(),
      builder: (context, child) {
        final controller = context.read<HomeController>();
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.w16),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: AppSizes.h16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Selector<HomeController, String?>(
                              selector: (BuildContext context, controller) =>
                                  controller.userImagePath,
                              builder: (context, String? userImage, child) {
                                return CircleAvatar(
                                  radius: AppSizes.r22,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: userImage != null
                                      ? FileImage(File(userImage))
                                      : AssetImage('assets/images/person.png'),
                                  
                                );
                              },
                            ),
                            SizedBox(width: AppSizes.w8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Selector<HomeController, String?>(
                                  selector:
                                      (
                                        BuildContext context,
                                        HomeController controller,
                                      ) => controller.username,
                                  builder:
                                      (
                                        BuildContext context,
                                        String? username,
                                        child,
                                      ) {
                                        return Text(
                                          username == null
                                              ? "Good Evening ,"
                                              : "Good Evening ,$username",
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                        );
                                      },
                                ),

                                Text(
                                  controller.motivationQuote == null
                                      ? "One task at a time. One step closer."
                                      : controller.motivationQuote.toString(),
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: AppSizes.h20),
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
                            SizedBox(width: AppSizes.w8),
                            CustomSvgPicture.withoutColor(
                              path: "assets/images/waving_hand.svg",
                              width: AppSizes.w28,
                              height: AppSizes.h28,
                            ),
                          ],
                        ),
                        SizedBox(height: AppSizes.h16),
                        AchievedTasksWidget(),
                        SizedBox(height: AppSizes.h8),
                        HighPriorityTasksWidget(),
                        Padding(
                          padding: EdgeInsets.only(
                            top: AppSizes.h24,
                            bottom: AppSizes.h16,
                          ),
                          child: Text(
                            "My Tasks",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(fontSize: AppSizes.sp20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverTaskListWidget(
                  emptyMessage:
                      "The are no tasks yet... Click + to add the first task ✍",
                ),
              ],
            ),
          ),
          floatingActionButton: SizedBox(
            height: AppSizes.h44,
            child: Builder(
              builder: (context) {
                return FloatingActionButton.extended(
                  onPressed: () async {
                    final bool? result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTask()),
                    );
                    if (result != null && result) {
                      if (!context.mounted) return;

                      await context.read<TasksController>().init();
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.r30),
                  ),
                  icon: Icon(Icons.add),
                  label: Text("Add New Task"),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
