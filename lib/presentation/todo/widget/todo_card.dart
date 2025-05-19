import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_sql/models/todo_model.dart';
import 'package:todo_app_sql/presentation/todo/bloc/todo_bloc.dart';
import 'package:todo_app_sql/utils.dart';

class TodoCard extends StatefulWidget {
  final List<TodoModel> datas;
  final BuildContext cxt;

  const TodoCard({
    super.key,
    required this.datas,
    required this.cxt,
  });

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  List<String> popupMenuList = [
    'Edit',
    'Delete',
  ];
  @override
  Widget build(BuildContext context) {
    if (widget.datas.isEmpty) {
      return const Center(
        child: Text(
          "No Todos",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: widget.datas.length,
      itemBuilder: (context, index) {
        final data = widget.datas[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text(data.title),
            subtitle: Column(
              children: [
                Text(data.description),
                Text("${data.dateTime}"),
              ],
            ),
            trailing: showMenuList(
              todo: data,
              cxt: widget.cxt,
            ),
          ),
        );
      },
    );
  }

  Widget showMenuList({
    required TodoModel todo,
    required BuildContext cxt,
  }) {
    return PopupMenuButton(
      onSelected: (value) => optionsSelected(
        cxt: cxt,
        todo: todo,
        value: value,
      ),
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) {
        return popupMenuList.map((e) {
          return PopupMenuItem(
            value: e,
            child: Text(e),
          );
        }).toList();
      },
    );
  }

  // method for selecting value
  Future<void> optionsSelected({
    required TodoModel todo,
    required String value,
    required BuildContext cxt,
  }) async {
    if (value == 'Edit') {
      final todoObject = TodoModel.todoObject(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        dateTime: todo.dateTime,
      );
      final event = TodoUpdateButtonClickedEvent(todo: todoObject);
      context.read<TodoBloc>().add(event);

      // log('edit mode');
    } else if (value == 'Delete') {
      final event = TodoDeleteEvent(id: todo.id);
      final bloc = context.read<TodoBloc>();
      bloc.add(event);
      final snackBar = createdSnackBar(
        message: 'Todo deleted',
        color: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
