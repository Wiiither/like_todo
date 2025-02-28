import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_todo/base/custom_color.dart';
import 'package:like_todo/bloc/todo/todo_bloc.dart';
import 'package:like_todo/page/main_page.dart';

import 'bloc/tab_bar/tab_bar_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          primaryColor: CustomColor.mainColor,
          useMaterial3: true,
          scaffoldBackgroundColor: CustomColor.backgroundColor,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TabBarBloc(),
            ),
            BlocProvider(
              create: (context) => TodoBloc()
                ..add(ReloadTodoGroupEvent())
                ..add(GetAllGroupTodoEvent())
                ..add(ReloadAllTodoEvent()),
            ),
          ],
          child: MainPage(),
        ));
  }
}
