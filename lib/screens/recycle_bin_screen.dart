import 'package:flutter/material.dart';
import 'package:todo_app/screens/app_drawer.dart';
import 'package:todo_app/widgets/tasks_list.dart';

class RecycleBinScreen extends StatelessWidget {
  const RecycleBinScreen({super.key});
  static const id = 'recycle_bin_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recycle Bin'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Chip(
              label: Text(
                'Tasks',
              ),
            ),
          ),
          Expanded(
            child: TaskList(
              taskList: [],
            ),
          ),
        ],
      ),
    );
  }
}
