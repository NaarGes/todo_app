import 'package:flutter/material.dart';
import 'package:todo_app/screens/recycle_bin_screen.dart';
import 'package:todo_app/screens/tabs_screen.dart';
import 'package:todo_app/screens/pending_tasks_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RecycleBinScreen.id:
        return MaterialPageRoute(builder: (_) => const RecycleBinScreen());
      case TabsScreen.id:
        return MaterialPageRoute(builder: (_) => const TabsScreen());
      default:
        return null;
    }
  }
}