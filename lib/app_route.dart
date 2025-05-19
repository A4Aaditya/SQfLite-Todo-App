import 'package:todo_app_sql/presentation/todo/add_todo.dart';
import 'package:todo_app_sql/presentation/todo/todo_screen.dart';

class AppRoute {
  static const homeScreen = '/homeScreen';
  static const addTodoScreen = '/addTodoScreen';

  static Map<String, dynamic> routes = {
    homeScreen: (context) => const HomeScreen(),
    addTodoScreen: (context) => const AddTodoScreen(),
  };
}
