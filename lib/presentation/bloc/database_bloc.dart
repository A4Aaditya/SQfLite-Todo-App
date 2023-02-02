import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_sql/repository/database.dart';
import 'package:todo_app_sql/models/todo_model.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  DataBaseRepository database;
  DatabaseBloc(this.database) : super(DatabaseInitial()) {
    on<DatabaseFetchEvent>(_fetchData);
    on<DatabaseInserEvent>(_insertData);
    on<DatabaseDeleteEvent>(_deleteData);
    on<DatabaseUpdateEvent>(_updateData);
  }
// Fetch Data form database
  FutureOr<void> _fetchData(
    DatabaseFetchEvent event,
    Emitter<DatabaseState> emit,
  ) async {
    emit(DatabaseLoading());
    try {
      final response = await database.getDatabaseData();

      if (response.isNotEmpty) {
        emit(DatabaseFetchSuccess(datas: response));
      } else {
        emit(DatabaseError(errorMessage: 'Unable to load data!'));
      }
    } catch (e) {
      emit(DatabaseError(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _insertData(
    DatabaseInserEvent event,
    Emitter<DatabaseState> emit,
  ) async {
    emit(DatabaseLoading());
    try {
      final response = await database.insertToDatabase(event.values);

      if (response != null) {
        emit(DatabaseLoading());
        final response = await database.getDatabaseData();
        emit(DatabaseFetchSuccess(datas: response));
      }
    } catch (e) {
      emit(
        DatabaseError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _deleteData(
    DatabaseDeleteEvent event,
    Emitter<DatabaseState> emit,
  ) async {
    emit(DatabaseLoading());
    try {
      final response = await database.deleteDataById(event.id);
      if (response != null) {
        emit(DatabaseLoading());
        final response = await database.getDatabaseData();
        emit(DatabaseFetchSuccess(datas: response));
      }
    } catch (e) {
      emit(
        DatabaseError(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _updateData(
    DatabaseUpdateEvent event,
    Emitter<DatabaseState> emit,
  ) async {
    emit(DatabaseLoading());
    try {
      final response = await database.updateDataById(event.values, event.id);
      if (response != null) {
        emit(DatabaseLoading());
        final response = await database.getDatabaseData();
        emit(DatabaseFetchSuccess(datas: response));
      }
    } catch (e) {
      emit(
        DatabaseError(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
