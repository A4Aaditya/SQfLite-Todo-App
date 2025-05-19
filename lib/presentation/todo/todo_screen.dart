import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_sql/app_route.dart';
import 'package:todo_app_sql/presentation/todo/bloc/todo_bloc.dart';
import 'package:todo_app_sql/presentation/todo/widget/todo_card.dart';
import 'package:todo_app_sql/presentation/widget/loading_widget.dart';

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
        listener: (cxt, state) {
          final status = state.status;
          const todoErrorState = TodoStateStatus.errorState;
          const todoInsertedState = TodoStateStatus.todoInserted;
          const todoDeletedState = TodoStateStatus.todoDeleted;
          const todoUpdatedState = TodoStateStatus.todoUpdated;
          const todoUpdateMode = TodoStateStatus.todoUpdateMode;

          switch (status) {
            case todoInsertedState:
              getSQLData();
              break;

            case todoDeletedState:
              getSQLData();
              break;

            case todoUpdatedState:
              getSQLData();
              break;

            case todoErrorState:
              showSnackBarCustom(state.errorMessage);
              break;

            case todoUpdateMode:
              Navigator.pushNamed(context, AppRoute.addTodoScreen);
              break;

            default:
              break;
          }
        },
        builder: (cxt, state) {
          // final status = state.status;
          // const todoFetch = TodoStateStatus.fetchedTodo;
          // const todoLoading = TodoStateStatus.loading;

          return TodoCard(
            datas: state.datas,
            cxt: cxt,
          );

          // switch (status) {
          //   case todoFetch:
          //     return TodoCard(
          //       datas: state.datas,
          //       cxt: cxt,
          //     );

          //   case todoLoading:
          //     return const LoadingWidget();

          //   default:
          //     return const SizedBox();
          // }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => navigateToAddTodo(context),
        label: const Text('Add Todo'),
      ),
    );
  }

  void navigateToAddTodo(BuildContext context) {
    final event = TodoAddModeEvent();
    context.read<TodoBloc>().add(event);
    Navigator.pushNamed(context, AppRoute.addTodoScreen);
  }

  Future<void> getSQLData() async {
    final event = TodoFetchEvent();
    final bloc = context.read<TodoBloc>();
    bloc.add(event);
  }

  void showSnackBarCustom(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
