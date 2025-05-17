import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_sql/app_route.dart';
import 'package:todo_app_sql/data/db/db_service.dart';
import 'package:todo_app_sql/presentation/add_todo.dart';
import 'package:todo_app_sql/presentation/bloc/database_bloc.dart';
import 'package:todo_app_sql/presentation/home_screen.dart';
import 'package:todo_app_sql/repository/todo_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
          create: (context) => TodoBloc(
            todoRepository: TodoRepository(
              dbService: DBService(),
            ),
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
        // theme: ThemeData.dark(),
      ),
    );
  }
}
