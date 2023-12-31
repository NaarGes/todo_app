import 'package:flutter/material.dart';
import 'package:todo_app/blocs/bloc_exports.dart';
import 'package:todo_app/models/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> taskList;

  const TaskList({super.key, required this.taskList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(taskList[index].title),
          trailing: Checkbox(
            onChanged: (_) => context.read<TasksBloc>().add(UpdateTask(task: taskList[index])),
            value: taskList[index].isDone,
          ),
        );
      },
    );
  }
}
