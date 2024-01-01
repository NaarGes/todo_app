import 'package:flutter/material.dart';

import '../blocs/bloc_exports.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) => context.read<TasksBloc>().add(DeleteTask(task: task)),
      key: ValueKey(task.id),
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Checkbox(
          onChanged: (_) => context.read<TasksBloc>().add(UpdateTask(task: task)),
          value: task.isDone,
        ),
      ),
    );
  }
}
