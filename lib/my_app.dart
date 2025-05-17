class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DatabaseBloc>(
          create: (context) => DatabaseBloc(
            DataBaseRepository(),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoute.homeScreen: (context) => const HomeScreen(),
          AppRoute.addTodoScreen: (context) => const AddTodoScreen()
        },
        home: const HomeScreen(),
        // theme: ThemeData.dark(),
      ),
    );
  }
}
