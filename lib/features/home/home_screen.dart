import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widget/custom_svg_picture.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/features/add_task/add_task_screen.dart';
import 'package:tasky/widgets/high_priority_tasks_widget.dart';
import 'package:tasky/widgets/achieved_tasks_widget.dart';
import 'package:tasky/widgets/sliver_task_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // In this List I store all Tasks
  List<TaskModel> tasks = [];
  bool isLoading = true;
  String? _username;
  String? _motivationQuote;
  String? userImagePath;
  int totalTasks = 0;
  int totalDoneTasks = 0;
  double percent = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
    _loadTask();
  }

  void _loadData() async {
    if (_username == null || _motivationQuote == null) {
      setState(() {
        _username = PreferencesManager().getString("username");
        _motivationQuote = PreferencesManager().getString("motivationquote");
        userImagePath = PreferencesManager().getString("user_image");
      });
    }
  }

  // imp think in this Function is load a tasks and Store in tasks.
  void _loadTask() async {
    // After Decode the value type is List<Map<String, dynamic>>
    final String? finalTask = PreferencesManager().getString("tasks");

    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      // List<Map<String, dynamic>>

      setState(() {
        tasks = taskAfterDecode
            .map((element) => TaskModel.formJson(element))
            .toList();

        _calculatePercent();
      }); // List of TaskModel
    }
    setState(() {
      isLoading = false;
    });
  }

  void _calculatePercent() {
    totalTasks = tasks.length;
    totalDoneTasks = tasks.where((element) => element.isDone).length;
    // calc the avrg
    percent = totalTasks == 0 ? 0 : totalDoneTasks / totalTasks;
  }

  void _doneTask(bool? value, int index) async {
    setState(() {
      // Edit in List tasks and save the value changed (isDone) in the List
      tasks[index].isDone = value ?? false;
      _calculatePercent();
    });
    // Convert a tasks of TaskModel into List of Map<String, dynamic>
    final updatedTask = tasks.map((e) => e.toJson()).toList();
    await PreferencesManager().setString("tasks", jsonEncode(updatedTask));
  }

  void _deleteTask(int? id) async {
    if (id == null) return;
    setState(() {
      tasks.removeWhere((element) => element.id == id);
      _calculatePercent();
    });

    // Convert a tasks of TaskModel into List of Map<String, dynamic>
    final updatedTask = tasks.map((e) => e.toJson()).toList();
    await PreferencesManager().setString("tasks", jsonEncode(updatedTask));
  }

  @override
  Widget build(BuildContext context) {
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
                          backgroundImage: userImagePath != null
                              ? FileImage(File(userImagePath!))
                              : null,
                          child: ClipOval(
                            child: userImagePath == null
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
                              _username == null
                                  ? "Good Evening ,"
                                  : "Good Evening ,$_username",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              _motivationQuote == null
                                  ? "One task at a time. One step closer."
                                  : "$_motivationQuote",
                              style: Theme.of(context).textTheme.titleSmall,
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
                      totalTasks: totalTasks,
                      totalDoneTasks: totalDoneTasks,
                      percent: percent,
                    ),
                    const SizedBox(height: 8),
                    HighPriorityTasksWidget(
                      tasks: tasks,
                      refresh: _loadTask,
                      onTap: (value, index) => _doneTask(value, index),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0, bottom: 16),
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
            isLoading
                ? SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFFFCFC),
                      ),
                    ),
                  )
                : SliverTaskListWidget(
                    tasks: tasks,
                    emptyMessage:
                        "The are no taske yet... Clike + to add the first task ✍",
                    onTap: (bool? value, int index) => _doneTask(value, index),
                    onDelete: (int? id) => _deleteTask(id),
                    onEdit: () => _loadTask(),
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
              _loadTask();
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
  }
}
