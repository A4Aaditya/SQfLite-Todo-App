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
        title: const Text('Home Screen'),
      ),
      body: BlocConsumer<DatabaseBloc, DatabaseState>(
        listener: (context, state) {
          if (state is DatabaseError) {
            final snackBar = SnackBar(
              content: Text(
                state.errorMessage,
              ),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state is DatabaseFetchSuccess) {
            return TodoCard(datas: state.datas);
          } else if (state is DatabaseLoading) {
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
    final event = DatabaseFetchEvent();
    final bloc = context.read<DatabaseBloc>();
    bloc.add(event);
  }
}
