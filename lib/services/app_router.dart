import 'package:flutter/material.dart';
import 'package:todo_app/screens/recycle_bin_screen.dart';
import 'package:todo_app/screens/tasks_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBinScreen.id:
        return MaterialPageRoute(builder: (_) => const RecycleBinScreen());
      case TasksScreen.id:
        return MaterialPageRoute(builder: (_) => const TasksScreen());
      default:
        return null;
    }
  }
}