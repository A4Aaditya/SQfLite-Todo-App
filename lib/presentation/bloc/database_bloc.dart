import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_sql/models/todo_model.dart';
import 'package:todo_app_sql/repository/todo_repository.dart';

part 'database_event.dart';
part 'database_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  // DataBaseRepository database;
  TodoRepository todoRepository;
  TodoBloc({
    // required this.database,
    required this.todoRepository,
  }) : super(TodoInitial()) {
    on<TodoFetchEvent>(_fetchData);
    on<TodoInsertEvent>(_insertData);
    on<TodoDeleteEvent>(_deleteData);
    on<TodoUpdateEvent>(_updateData);
  }
// Fetch Data form database
  FutureOr<void> _fetchData(
    TodoFetchEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    try {
      // final response = await database.getDatabaseData();
      final response = await todoRepository.getAllQuerry();

      emit(TodoFetchSuccess(datas: response));
    } catch (e) {
      emit(TodoError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _insertData(
    TodoInsertEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    try {
      // final response = await database.insertToDatabase(event.values);
      final response = await todoRepository.insertTodo(values: event.values);

      if (!response.isNaN) {
        emit(TodoLoading());
        // final response = await database.getDatabaseData();
        final response = await todoRepository.getAllQuerry();
        emit(TodoFetchSuccess(datas: response));
      }
    } catch (e) {
      emit(
        TodoError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _deleteData(
    TodoDeleteEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    try {
      // final response = await database.deleteDataById(event.id);
      final response = await todoRepository.deleteTodoById(id: event.id);
      if (!response.isNaN) {
        emit(TodoLoading());
        // final response = await database.getDatabaseData();
        final response = await todoRepository.getAllQuerry();
        emit(TodoFetchSuccess(datas: response));
      }
    } catch (e) {
      emit(
        TodoError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _updateData(
    TodoUpdateEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    try {
      // final response = await database.updateDataById(event.values, event.id);
      final response = await todoRepository.updateTodoById(
        id: event.id,
        values: event.values,
      );
      if (response != null) {
        emit(TodoLoading());
        // final response = await database.getDatabaseData();
        final response = await todoRepository.getAllQuerry();
        emit(TodoFetchSuccess(datas: response));
      }
    } catch (e) {
      emit(
        TodoError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
