import 'package:flutter/material.dart';
import 'package:todo_app/blocs/bloc_exports.dart';
import 'package:todo_app/models/task.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTask;

  const EditTaskScreen({
    super.key,
    required this.oldTask,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: oldTask.title);
    TextEditingController descriptionController = TextEditingController(text: oldTask.description);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            'Edit Task',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              label: Text('Title'),
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: descriptionController,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
              label: Text('Description'),
              border: OutlineInputBorder(),
            ),
            autofocus: true,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('cancel'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Title and Description cannot be empty!'),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 1),
                      ));
                      return;
                    }
                    final editedTask = oldTask.copyWith(
                      title: titleController.text,
                      description: descriptionController.text,
                      isDone: false,
                    );
                    context.read<TasksBloc>().add(EditTask(oldTask: oldTask, newTask: editedTask));
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
