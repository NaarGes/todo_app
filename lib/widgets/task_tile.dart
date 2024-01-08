import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  void _removeOrDeleteTask(BuildContext context, Task task) {
    task.isDeleted
        ? context.read<TasksBloc>().add(DeleteTask(task: task))
        : context.read<TasksBloc>().add(RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) => _removeOrDeleteTask(context, task),
      key: ValueKey(task.id),
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Checkbox(
          onChanged: !task.isDeleted ? (_) => context.read<TasksBloc>().add(UpdateTask(task: task)) : null,
          value: task.isDone,
        ),
      ),
    );
  }
}
