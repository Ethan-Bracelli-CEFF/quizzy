import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_list/quiz_list.dart';
import 'package:quiz_repository/quiz_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<QuizLocalStorage>(
          create: (context) => QuizLocalStorage(),
        ),
        Provider<QuizRepository>(
          create: (context) => QuizRepository(
            storage: context.read<QuizLocalStorage>(),
          ),
        ),
        Provider<QuizListProvider>(
          create: (context) => QuizListProvider(
            repository: context.read<QuizRepository>(),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quizzy',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {},
      ),
    );
  }
}
