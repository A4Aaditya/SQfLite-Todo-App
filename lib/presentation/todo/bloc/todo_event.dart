part of 'todo_bloc.dart';

abstract class TodoEvent {}

class TodoFetchEvent extends TodoEvent {}

class TodoInsertEvent extends TodoEvent {
  final Map<String, dynamic> values;
  TodoInsertEvent({
    required this.values,
  });
}

class TodoDeleteEvent extends TodoEvent {
  final int id;
  TodoDeleteEvent({required this.id});
}

class TodoUpdateEvent extends TodoEvent {
  final Map<String, dynamic> values;
  final int id;
  TodoUpdateEvent({
    required this.id,
    required this.values,
  });
}

class TodoUpdateButtonClickedEvent extends TodoEvent {
  final TodoModel todo;
  TodoUpdateButtonClickedEvent({
    required this.todo,
  });
}

class TodoSelectDateEvent extends TodoEvent {
  final DateTime? dateTime;
  TodoSelectDateEvent({required this.dateTime});
}

class TodoAddModeEvent extends TodoEvent {}

class TodoSelectCategoryEvent extends TodoEvent {
  final String category;
  TodoSelectCategoryEvent({required this.category});
}

class TodoTitleChangeEvent extends TodoEvent {
  final String title;
  TodoTitleChangeEvent({required this.title});
}

class TodoDescriptionChangeEvent extends TodoEvent {
  final String description;
  TodoDescriptionChangeEvent({required this.description});
}
