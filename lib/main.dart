import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

import 'blocs/bloc_exports.dart';
import 'screens/tasks_screen.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc()..add(AddTask(task: Task(title: 'task 1'))),
      child: MaterialApp(
        title: 'Flutter Todo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TasksScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
