import 'package:todo_app_sql/data/db/db_helper.dart';

class DBService {
  final instance = DBHelper.instance;

  Future<int> insertData({
    required Map<String, dynamic> values,
    required String table,
  }) async {
    final db = await instance.getDatabase();

    return await db.insert(table, values);
  }

  Future<int> deleteById({
    required String table,
    required int id,
  }) async {
    final db = await instance.getDatabase();

    return await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateById({
    required int id,
    required String table,
    required Map<String, dynamic> values,
  }) async {
    final db = await instance.getDatabase();

    return await db.update(
      table,
      values,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<List<Map<String, Object?>>> getAllQuerry({
    required String table,
  }) async {
    final db = await instance.getDatabase();

    return await db.query(table);
  }
}
