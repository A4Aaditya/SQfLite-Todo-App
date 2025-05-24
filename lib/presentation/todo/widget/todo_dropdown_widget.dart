import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_sql/constant/todo_category_constant.dart';
import 'package:todo_app_sql/presentation/todo/bloc/todo_bloc.dart';

class AddTodoDropDownWidget extends StatelessWidget {
  const AddTodoDropDownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final myList = TodoCategoryConstants.todoCategoryList;
    return BlocBuilder<TodoBloc, TodoState>(builder: (cxt, state) {
      return DropdownButton(
        hint: const Text("Select Cateogory"),
        isExpanded: true,
        autofocus: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        value: state.cateogory,
        onChanged: (value) {
          final event = TodoSelectCategoryEvent(category: value.toString());
          cxt.read<TodoBloc>().add(event);
        },
        items: myList.map((e) {
          return DropdownMenuItem(
            value: e.toString(),
            child: Text(e),
          );
        }).toList(),
      );
    });
  }
}
