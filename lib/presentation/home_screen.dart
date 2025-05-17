import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_sql/app_route.dart';
import 'package:todo_app_sql/presentation/bloc/database_bloc.dart';
import 'package:todo_app_sql/presentation/widget/todo_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getSQLData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoError) {
            final snackBar = SnackBar(
              content: Text(
                state.errorMessage,
              ),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is TodoDataInsertedState ||
              state is TodoDataDeletedState ||
              state is TodoDataUpdatedState) {
            getSQLData();
          }
        },
        builder: (context, state) {
          if (state is TodoFetchSuccess) {
            return TodoCard(datas: state.datas);
          } else if (state is TodoLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddTodo,
        label: const Text('Add Todo'),
      ),
    );
  }

  void navigateToAddTodo() {
    Navigator.pushNamed(context, AppRoute.addTodoScreen);
  }

  Future<void> getSQLData() async {
    final event = TodoFetchEvent();
    final bloc = context.read<TodoBloc>();
    bloc.add(event);
  }
}
