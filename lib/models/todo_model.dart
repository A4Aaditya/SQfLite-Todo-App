class TodoModel {
  final int id;
  final String title;
  final String description;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory TodoModel.fromMap(Map<String, dynamic> data) {
    return TodoModel(
      id: data['id'],
      title: data['title'],
      description: data['description'],
    );
  }
}
