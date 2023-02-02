import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_sql/models/todo_model.dart';
import 'package:todo_app_sql/presentation/add_todo.dart';
import 'package:todo_app_sql/presentation/bloc/database_bloc.dart';
import 'package:todo_app_sql/utils.dart';

class TodoCard extends StatefulWidget {
  final List<TodoModel> datas;

  const TodoCard({
    super.key,
    required this.datas,
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
            subtitle: Text(data.description),
            trailing: showMenuList(
              id: data.id,
              title: data.title,
              description: data.description,
            ),
          ),
        );
      },
    );
  }

  Widget showMenuList({
    required int id,
    required String title,
    required String description,
  }) {
    return PopupMenuButton(
      onSelected: (value) => optionsSelected(
        value: value,
        id: id,
        title: title,
        description: description,
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
    required String value,
    required int id,
    required String title,
    required String description,
  }) async {
    if (value == 'Edit') {
      final route = MaterialPageRoute(
        builder: (context) => AddTodoScreen(
          id: id,
          title: title,
          description: description,
          isEditMode: true,
        ),
      );
      Navigator.push(context, route);

      log('edit mode');
    } else if (value == 'Delete') {
      final event = DatabaseDeleteEvent(id: id);
      final bloc = context.read<DatabaseBloc>();
      bloc.add(event);
      final snackBar = createdSnackBar(
        message: 'Todo deleted',
        color: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
