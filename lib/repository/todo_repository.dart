import 'package:todo_app_sql/data/db/db_constant.dart';
import 'package:todo_app_sql/data/db/db_service.dart';
import 'package:todo_app_sql/models/todo_model.dart';

class TodoRepository {
  final DBService dbService;
  final table = DBConstant.todoTable;

  TodoRepository({required this.dbService});

  Future<int> insertTodo({
    required Map<String, dynamic> values,
  }) async {
    final response = await dbService.insertData(values: values, table: table);

    // log("TodoRepository :After todo insert $response");
    return response;
  }

  Future<int> updateTodoById({
    required int id,
    required Map<String, dynamic> values,
  }) async {
    final response = await dbService.updateById(
      id: id,
      table: table,
      values: values,
    );
    // log("TodoRepository :After todo updateById $response");
    return response;
  }

  Future<int> deleteTodoById({
    required int id,
  }) async {
    final response = await dbService.deleteById(
      table: table,
      id: id,
    );

    // log("TodoRepository :After todo deleteById $response");
    return response;
  }

  Future<List<TodoModel>> getAllQuerry() async {
    final response = await dbService.getAllQuerry(
      table: table,
    );
    final todoData = response.map((todoJson) {
      return TodoModel.fromMap(todoJson);
    }).toList();

    // log("TodoRepository :After todo getAllQuerry $response");
    return todoData;
  }
}
