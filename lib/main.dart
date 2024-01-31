import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/screens/tabs_screen.dart';
import 'package:todo_app/services/app_router.dart';
import 'package:todo_app/services/app_theme.dart';

import 'blocs/bloc_exports.dart';

void main() async {
  await _init();
  runApp(
    App(
      router: AppRouter(),
    ),
  );
}

class App extends StatelessWidget {
  final AppRouter router;

  const App({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksBloc()),
        BlocProvider(create: (context) => SwitchBloc()),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Todo App',
            theme: state.switchValue
                ? AppThemes.appThemeData[AppTheme.darkTheme]
                : AppThemes.appThemeData[AppTheme.lightTheme],
            home: const TabsScreen(),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: router.onGenerateRoute,
          );
        },
      ),
    );
  }
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
}
