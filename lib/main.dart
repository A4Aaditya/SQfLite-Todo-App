import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_sql/bloc_observer.dart';
import 'package:todo_app_sql/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = TodoAppBlocObserver();
  runApp(const MyApp());
}
