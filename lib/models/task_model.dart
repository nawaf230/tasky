class TaskModel {
  // information of Task
  final int id;
  final String taskName;
  final String taskDescription;
  final bool isHighPriority;
  bool isDone;

  TaskModel({
    required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
    this.isDone = false,
  });

  // Convert JSON → Dart Object (TaskModel object).
  factory TaskModel.formJson(Map<String, dynamic> json) {
    // The return value of this Method is Object of type TaskModel.
    return TaskModel(
      id: json["id"],
      taskName: json["taskName"],
      taskDescription: json["taskDescription"],
      isHighPriority: json["isHighPriority"],
      isDone: json["isDone"] ?? false,
    );
  }

  // Convert Dart (TaskModel object) Object → JSON
  // can be name this method toMap but more Best named toJson
  Map<String, dynamic> toJson() {
    // This method return value Type Json (Map<String ,dynamic>).
    return {
      "id": id,
      "taskName": taskName,
      "taskDescription": taskDescription,
      "isHighPriority": isHighPriority,
      "isDone": isDone,
    };
  }

  @override
  String toString() {
    return 'TaskModel(id: $id,'
        ' taskName: $taskName,'
        ' taskDescription: $taskDescription,'
        ' isHighPriority: $isHighPriority,'
        'isDone: $isDone)';
  }
}
