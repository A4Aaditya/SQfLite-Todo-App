part of 'database_bloc.dart';

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
