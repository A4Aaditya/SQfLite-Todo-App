import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_sql/app_route.dart';
import 'package:todo_app_sql/presentation/bloc/database_bloc.dart';
import 'package:todo_app_sql/utils.dart';

class AddTodoScreen extends StatefulWidget {
  final int? id;
  final String? title;
  final String? description;
  final bool isEditMode;
  const AddTodoScreen({
    super.key,
    this.description,
    this.id,
    this.title,
    this.isEditMode = false,
  });

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  bool? isEditMode = false;
  @override
  void initState() {
    super.initState();
    titleController.text = widget.title ?? '';
    descriptionController.text = widget.description ?? '';
    isEditMode = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isEditMode
            ? const Text('Edit Todo')
            : const Text('Add Todo'),
      ),
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            TextFormField(
              controller: titleController,
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
            ElevatedButton(
              onPressed: onPressed,
              child: widget.isEditMode
                  ? const Text('Update')
                  : const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onPressed() async {
    final title = titleController.text;
    final description = descriptionController.text;
    final values = {
      'title': title,
      'description': description,
    };
    if (widget.isEditMode) {
      if (_globalKey.currentState?.validate() == true) {
        final event = DatabaseUpdateEvent(id: widget.id!, values: values);
        final bloc = context.read<DatabaseBloc>();
        bloc.add(event);
        final snackBar =
            createdSnackBar(message: 'Todo Updated', color: Colors.green);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushNamed(context, AppRoute.homeScreen);
      }
    } else {
      if (_globalKey.currentState?.validate() == true) {
        final event = DatabaseInserEvent(values: values);
        final bloc = context.read<DatabaseBloc>();
        bloc.add(event);
        final snackBar =
            createdSnackBar(message: 'Todo created', color: Colors.green);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.pushNamed(context, AppRoute.homeScreen);
      }
    }
  }
}
