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
    final parsedDateTime = DateTime.parse(data["dateTime"]);
    return TodoModel(
      id: data['id'],
      title: data['title'],
      dateTime: parsedDateTime,
      description: data['description'],
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
      'title': title,
      "dateTime": convertedDate,
      'description': descriptions,
    };
  }
}
