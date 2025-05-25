import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_sql/models/todo_model.dart';
import 'package:todo_app_sql/repository/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoRepository todoRepository;

  TodoBloc({
    required this.todoRepository,
  }) : super(TodoState.initial()) {
    on<TodoFetchEvent>(_fetchData);
    on<TodoInsertEvent>(_insertData);
    on<TodoDeleteEvent>(_deleteData);
    on<TodoUpdateButtonClickedEvent>(_onUpdateButtonClicked);
    on<TodoAddModeEvent>(_todoAddMode);
    on<TodoSelectDateEvent>(_todoSelectDate);
    on<TodoUpdateEvent>(_updateData);
    on<TodoSelectCategoryEvent>(_selectTodoCategory);
    on<TodoTitleChangeEvent>(_todoTitleChange);
    on<TodoDescriptionChangeEvent>(_todoDescriptionChange);
  }
// Fetch Data form database
  FutureOr<void> _fetchData(
    TodoFetchEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(
      state.copyWith(status: TodoStateStatus.loading),
    );
    try {
      final response = await todoRepository.getAllQuerry();
      emit(
        state.copyWith(
          datas: response,
          status: TodoStateStatus.fetchedTodo,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: TodoStateStatus.errorState,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _insertData(
    TodoInsertEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(
      state.copyWith(status: TodoStateStatus.loading),
    );
    try {
      final response = await todoRepository.insertTodo(values: event.values);

      if (response == 1) {
        emit(
          state.copyWith(status: TodoStateStatus.todoInserted),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
            status: TodoStateStatus.errorState, errorMessage: e.toString()),
      );
    }
  }

  FutureOr<void> _deleteData(
    TodoDeleteEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(
      state.copyWith(status: TodoStateStatus.loading),
    );
    try {
      final response = await todoRepository.deleteTodoById(id: event.id);
      if (response == 1) {
        emit(
          state.copyWith(status: TodoStateStatus.todoDeleted),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: TodoStateStatus.errorState,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _updateData(
    TodoUpdateEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(
      state.copyWith(status: TodoStateStatus.loading),
    );
    try {
      final response = await todoRepository.updateTodoById(
        id: event.id,
        values: event.values,
      );
      if (response == 1) {
        emit(
          state.copyWith(status: TodoStateStatus.todoUpdated),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: TodoStateStatus.errorState,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdateButtonClicked(
    TodoUpdateButtonClickedEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(
      state.copyWith(
        editMode: true,
        id: event.todo.id,
        title: event.todo.title,
        descriptions: event.todo.description,
        date: event.todo.dateTime,
        cateogory: event.todo.cateogory,
      ),
    );
  }

  Future<void> _todoSelectDate(
    TodoSelectDateEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(state.copyWith(
      date: event.dateTime,
    ));
  }

  void _todoAddMode(
    TodoAddModeEvent event,
    Emitter<TodoState> emit,
  ) {
    emit(
      state.copyWith(
        title: "",
        descriptions: "",
        editMode: false,
        date: null,
        cateogory: null,
      ),
    );
  }

  void _selectTodoCategory(
    TodoSelectCategoryEvent event,
    Emitter<TodoState> emit,
  ) {
    emit(
      state.copyWith(cateogory: event.category),
    );
  }

  void _todoTitleChange(
    TodoTitleChangeEvent event,
    Emitter<TodoState> emit,
  ) {
    emit(state.copyWith(
      title: event.title,
    ));
  }

  void _todoDescriptionChange(
    TodoDescriptionChangeEvent event,
    Emitter<TodoState> emit,
  ) {
    emit(state.copyWith(
      descriptions: event.description,
    ));
  }
}
