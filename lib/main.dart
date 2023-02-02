import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_sql/presentation/add_todo.dart';
import 'package:todo_app_sql/app_route.dart';
import 'package:todo_app_sql/repository/database.dart';
import 'package:todo_app_sql/presentation/bloc/database_bloc.dart';
import 'package:todo_app_sql/presentation/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DatabaseBloc>(
          create: (context) => DatabaseBloc(
            DataBaseRepository(),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoute.homeScreen: (context) => const HomeScreen(),
          AppRoute.addTodoScreen: (context) => const AddTodoScreen()
        },
        home: const HomeScreen(),
        theme: ThemeData.dark(),
      ),
    );
  }
}
