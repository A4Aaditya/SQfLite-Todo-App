part of 'todo_bloc.dart';

enum TodoStateStatus {
  intial,
  loading,
  errorState,
  fetchedTodo,
  todoInserted,
  todoUpdated,
  todoDeleted,
}

class TodoState {
  int id;
  String title;
  String descriptions;
  DateTime? date;
  bool editMode;
  String? cateogory;
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
    required this.cateogory,
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
      cateogory: null,
    );
  }

  TodoState copyWith({
    int? id,
    String? title,
    bool? editMode,
    String? descriptions,
    DateTime? date,
    String? cateogory,
    String? errorMessage,
    List<TodoModel>? datas,
    TodoStateStatus? status,
  }) {
    return TodoState(
      id: id ?? this.id,
      editMode: editMode ?? this.editMode,
      title: title ?? this.title,
      descriptions: descriptions ?? this.descriptions,
      date: date ?? this.date,
      errorMessage: errorMessage ?? this.errorMessage,
      datas: datas ?? this.datas,
      cateogory: cateogory ?? this.cateogory,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return "$status";
  }
}
