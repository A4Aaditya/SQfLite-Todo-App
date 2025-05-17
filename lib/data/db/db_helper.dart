import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const _databaseName = 'todo.db';
  static const table = 'todos';

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
}
