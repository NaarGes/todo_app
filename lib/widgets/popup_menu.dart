import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback editCallback;
  final VoidCallback likeOrDislike;
  final VoidCallback cancelOrDeleteCallback;

  const PopupMenu({
    super.key,
    required this.task,
    required this.editCallback,
    required this.likeOrDislike,
    required this.cancelOrDeleteCallback,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => !task.isDeleted
          ? [
              PopupMenuItem(
                onTap: editCallback,
                child: TextButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
              ),
              PopupMenuItem(
                onTap: likeOrDislike,
                child: TextButton.icon(
                  onPressed: null,
                  icon: task.isFavorite
                      ? const Icon(Icons.bookmark_remove)
                      : const Icon(Icons.bookmark_add_outlined),
                  label: task.isFavorite
                      ? const Text('Remove from\nBookmarks')
                      : const Text('Add to\nBookmark'),
                ),
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
