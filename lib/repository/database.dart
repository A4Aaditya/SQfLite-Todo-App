import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_sql/models/todo_model.dart';

class DataBaseRepository {
  Database? database;
  final databaseName = 'todo.db';
  final table = 'todos';
  DataBaseRepository() {
    _init();
  }
  Future<void> _init() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''  
          CREATE TABLE $table (
          id INTEGER PRIMARY KEY,
          title TEXT,
          description TEXT
          );
          ''',
        );
      },
    );
  }

  Future<int?> insertToDatabase(Map<String, dynamic> values) async {
    if (database == null) {
      await _init();
    }
    try {
      final response = await database?.insert(table, values);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TodoModel>> getDatabaseData() async {
    if (database == null) {
      await _init();
    }
    try {
      final response = await database?.query(table);
      final datas = response ?? [];
      return datas.map((e) {
        return TodoModel.fromMap(e);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<int?> deleteDataById(int id) async {
    if (database == null) {
      await _init();
    }
    try {
      final response = await database?.delete(
        table,
        where: 'id = ?',
        whereArgs: [id],
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<int?> updateDataById(Map<String, dynamic> values, int id) async {
    if (database == null) {
      await _init();
    }
    try {
      final response = await database?.update(
        table,
        values,
        where: 'id = ?',
        whereArgs: [id],
      );

      log(response.toString());
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
