import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_sql/data/db/db_constant.dart';

class DBHelper {
  static const _databaseName = 'todo.db';

  DBHelper._privateConstructor();

  static final instance = DBHelper._privateConstructor();

  static Database? _database;

  Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE ${DBConstant.todoTable} (
          ${DBConstant.id} INTEGER PRIMARY KEY,
          ${DBConstant.title} TEXT,
          ${DBConstant.dateTime} TEXT,
          ${DBConstant.description} TEXT,
          ${DBConstant.category} TEXT
          );
          ''',
        );
      },
    );
  }
}
