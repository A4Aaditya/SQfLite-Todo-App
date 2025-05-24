import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_sql/app_route.dart';
import 'package:todo_app_sql/models/todo_model.dart';
import 'package:todo_app_sql/presentation/todo/bloc/todo_bloc.dart';
import 'package:todo_app_sql/presentation/todo/widget/todo_dropdown_widget.dart';
import 'package:todo_app_sql/utils.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    final todoBloc = BlocProvider.of<TodoBloc>(context, listen: false);
    if (todoBloc.state.editMode) {
      titleController.text = todoBloc.state.title;
      descriptionController.text = todoBloc.state.descriptions;
    } else {
      titleController.text = "";
      descriptionController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final todoBloc = context.watch<TodoBloc>();
    return Scaffold(
      appBar: AppBar(
        title: todoBloc.state.editMode
            ? const Text('Edit Todo')
            : const Text('Add Todo'),
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (cxt, state) {
          if (state.editMode) {
            titleController.text = state.title;
            descriptionController.text = state.descriptions;
          }
        },
        builder: (cxt, state) {
          return Form(
            key: _globalKey,
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                const AddTodoDropDownWidget(),
                TextFormField(
                  controller: titleController,
                  autofocus: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => validateField(
                      controller: titleController,
                      errorMessage: 'Please enter title'),
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: descriptionController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => validateField(
                      controller: descriptionController,
                      errorMessage: 'Please enter description'),
                  keyboardType: TextInputType.multiline,
                  maxLines: 8,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Description',
                  ),
                ),
                const SizedBox(height: 30),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    state.date == null
                        ? 'Select Due Date'
                        : 'Due Date: ${state.date}',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      final event = TodoSelectDateEvent(dateTime: picked);
                      cxt.read<TodoBloc>().add(event);
                    }
                  },
                ),
                const SizedBox(height: 30),
                BlocBuilder<TodoBloc, TodoState>(builder: (cxt, state) {
                  final blocProvider = BlocProvider.of<TodoBloc>(cxt);
                  if (state.status == TodoStateStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      _handleSubmit(blocProvider);
                    },
                    child: state.editMode
                        ? const Text('Update')
                        : const Text('Submit'),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleSubmit(TodoBloc blocProvider) async {
    final title = titleController.text;

    final description = descriptionController.text;

    if (_globalKey.currentState?.validate() != true) return;
    if (blocProvider.state.date == null) return;
    if (blocProvider.state.cateogory == null) return;

    final values = TodoModel.toMap(
      title: title,
      dateTime: blocProvider.state.date!,
      descriptions: description,
      category: blocProvider.state.cateogory!,
    );

    final bloc = context.read<TodoBloc>();

    if (blocProvider.state.editMode) {
      final event = TodoUpdateEvent(id: blocProvider.state.id, values: values);

      bloc.add(event);

      final snackBar = createdSnackBar(
        message: 'Todo Updated',
        color: Colors.green,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final event = TodoInsertEvent(values: values);

      bloc.add(event);

      final snackBar = createdSnackBar(
        message: 'Todo created',
        color: Colors.green,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoute.homeScreen,
      (route) => false,
    );
  }
}
