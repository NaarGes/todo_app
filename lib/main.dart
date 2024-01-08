import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/services/app_router.dart';

import 'blocs/bloc_exports.dart';
import 'screens/tasks_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  runApp(MyApp(router: AppRouter()));
}

class MyApp extends StatelessWidget {
  final AppRouter router;
  const MyApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc(),
      child: MaterialApp(
        title: 'Flutter Todo App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const TasksScreen(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.onGenerateRoute,
      ),
    );
  }
}
