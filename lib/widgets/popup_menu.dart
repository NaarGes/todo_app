import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback cancelOrDeleteCallback;

  const PopupMenu({
    super.key,
    required this.cancelOrDeleteCallback,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => !task.isDeleted
          ? [
              PopupMenuItem(
                child: TextButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
                onTap: () {},
              ),
              PopupMenuItem(
                child: TextButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.bookmark),
                  label: const Text('Add to Bookmark'),
                ),
                onTap: () {},
              ),
              PopupMenuItem(
                onTap: cancelOrDeleteCallback,
                child: TextButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                ),
              ),
            ]
          : [
              PopupMenuItem(
                onTap: () {},
                child: TextButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.restore_from_trash),
                  label: const Text('Restore'),
                ),
              ),
              PopupMenuItem(
                onTap: cancelOrDeleteCallback,
                child: TextButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.delete_forever),
                  label: const Text('Delete Forever'),
                ),
              ),
            ],
    );
  }
}
