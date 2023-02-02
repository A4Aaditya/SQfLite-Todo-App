part of 'database_bloc.dart';

abstract class DatabaseState {}

class DatabaseInitial extends DatabaseState {}

class DatabaseLoading extends DatabaseState {}

class DatabaseError extends DatabaseState {
  final String errorMessage;
  DatabaseError({
    required this.errorMessage,
  });
}

class DatabaseFetchSuccess extends DatabaseState {
  final List<TodoModel> datas;

  DatabaseFetchSuccess({
    required this.datas,
  });
}
