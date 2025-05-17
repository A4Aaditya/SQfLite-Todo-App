part of 'database_bloc.dart';

abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoError extends TodoState {
  final String errorMessage;
  TodoError({
    required this.errorMessage,
  });
}

class TodoFetchSuccess extends TodoState {
  final List<TodoModel> datas;

  TodoFetchSuccess({
    required this.datas,
  });
}

class TodoDataInsertedState extends TodoState {}

class TodoDataUpdatedState extends TodoState {}

class TodoDataDeletedState extends TodoState {}
