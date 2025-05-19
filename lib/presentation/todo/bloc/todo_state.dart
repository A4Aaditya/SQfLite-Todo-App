part of 'todo_bloc.dart';

enum TodoStateStatus {
  intial,
  loading,
  errorState,
  fetchedTodo,
  todoInserted,
  todoAddMode,
  todoUpdateMode,
  todoUpdated,
  todoDeleted,
}

class TodoState {
  int id;
  String title;
  String descriptions;
  DateTime? date;
  bool editMode;
  String errorMessage;
  List<TodoModel> datas;
  TodoStateStatus status;

  TodoState({
    required this.id,
    required this.title,
    required this.descriptions,
    required this.date,
    required this.errorMessage,
    required this.datas,
    this.editMode = false,
    required this.status,
  });

  factory TodoState.initial() {
    return TodoState(
      id: 0,
      title: "",
      descriptions: "",
      date: null,
      errorMessage: "",
      datas: [],
      status: TodoStateStatus.intial,
    );
  }

  TodoState copyWith({
    int? id,
    String? title,
    bool? editMode,
    String? descriptions,
    DateTime? date,
    String? errorMessage,
    List<TodoModel>? datas,
    TodoStateStatus? status,
  }) {
    return TodoState(
      id: id ?? this.id,
      editMode: editMode ?? this.editMode,
      title: title ?? this.title,
      descriptions: descriptions ?? this.descriptions,
      date: date,
      errorMessage: errorMessage ?? this.errorMessage,
      datas: datas ?? this.datas,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return "$status";
  }
}
