import 'package:todo_app_sql/data/db/db_constant.dart';

class TodoModel {
  final int id;
  final String title;
  final String description;
  final DateTime dateTime;

  TodoModel({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.description,
  });

  factory TodoModel.fromMap(Map<String, dynamic> data) {
    final parsedDateTime = DateTime.parse(data[DBConstant.dateTime]);
    return TodoModel(
      id: data[DBConstant.id],
      title: data[DBConstant.title],
      dateTime: parsedDateTime,
      description: data[DBConstant.description],
    );
  }

  factory TodoModel.todoObject({
    required int id,
    required String title,
    required DateTime dateTime,
    required String description,
  }) {
    return TodoModel(
      id: id,
      title: title,
      dateTime: dateTime,
      description: description,
    );
  }

  static Map<String, dynamic> toMap({
    required String title,
    required DateTime dateTime,
    required String descriptions,
  }) {
    final convertedDate = dateTime.toIso8601String();
    return {
      DBConstant.title: title,
      DBConstant.dateTime: convertedDate,
      DBConstant.description: descriptions,
    };
  }
}
