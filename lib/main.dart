import 'package:flowly/cubit/board/board_cubit.dart';
import 'package:flowly/cubit/date/date_cubit.dart';
import 'package:flowly/cubit/description/description_cubit.dart';
import 'package:flowly/cubit/priority/priority_cubit.dart';
import 'package:flowly/cubit/task/tasks_cubit.dart';
import 'package:flowly/cubit/title/title_cubit.dart';
import 'package:flowly/cubit/username/username_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowly/router/routes.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final directory = await getApplicationDocumentsDirectory();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(directory.path),
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserNameCubit()),
        BlocProvider(create: (context) => BoardsCubit()),
        BlocProvider(create: (context) => TitleCubit()),
        BlocProvider(create: (context) => DescriptionCubit()),
        BlocProvider(create: (context) => PriorityCubit()),
        BlocProvider(create: (context) => DateCubit()),
        BlocProvider(create: (context) => TasksCubit()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}
