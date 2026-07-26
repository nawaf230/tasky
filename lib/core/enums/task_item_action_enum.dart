enum TaskItemActionEnum {
  markAsDone(name: "Done | UnDone"),
  edit(name: "Edit"),
  delete(name: "Delete");

  final String name;

  const  TaskItemActionEnum({required this.name});
}
