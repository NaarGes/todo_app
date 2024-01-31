import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/screens/edit_task_screen.dart';
import 'package:todo_app/widgets/popup_menu.dart';

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

  void _editTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: EditTaskScreen(oldTask: task),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          task.isFavorite ? const Icon(Icons.star) : const Icon(Icons.star_outline),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    decoration: task.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                Text(DateFormat().add_yMMMEd().add_Hms().format(DateTime.parse(task.date))),
              ],
            ),
          ),
          Checkbox(
            onChanged: !task.isDeleted
                ? (_) => context.read<TasksBloc>().add(UpdateTask(task: task))
                : null,
            value: task.isDone,
          ),
          PopupMenu(
            task: task,
            editCallback: () => _editTask(context),
            likeOrDislike: () => context.read<TasksBloc>().add(
                  MarkFavoriteOrUnFavoriteTask(task: task),
                ),
            cancelOrDeleteCallback: () => _removeOrDeleteTask(context, task),
            restoreCallback: () => context.read<TasksBloc>().add(RestoreEvent(task: task)),
          ),
        ],
      ),
    );
  }
}
