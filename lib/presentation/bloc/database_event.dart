part of 'database_bloc.dart';

abstract class DatabaseEvent {}

class DatabaseFetchEvent extends DatabaseEvent {}

class DatabaseInserEvent extends DatabaseEvent {
  final Map<String, dynamic> values;
  DatabaseInserEvent({
    required this.values,
  });
}

class DatabaseDeleteEvent extends DatabaseEvent {
  final int id;
  DatabaseDeleteEvent({required this.id});
}

class DatabaseUpdateEvent extends DatabaseEvent {
  final Map<String, dynamic> values;
  final int id;
  DatabaseUpdateEvent({
    required this.id,
    required this.values,
  });
}
