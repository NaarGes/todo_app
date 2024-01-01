import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  final List<Task> taskList;

  const TaskList({super.key, required this.taskList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return TaskTile(task: taskList[index]);
      },
    );
  }
}
