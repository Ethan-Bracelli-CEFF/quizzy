import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_list/quiz_list.dart';
import 'package:quiz_repository/quiz_repository.dart';

void main() {
  runApp(const Quizzy());
}

class Quizzy extends StatelessWidget {
  const Quizzy({super.key});

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
        ChangeNotifierProvider<QuizListProvider>(
          create: (context) => QuizListProvider(
            repository: context.read<QuizRepository>(),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quizzy',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const HomePageScreen(),
        // routes: {
        //   '/': (context) => const HomePageScreen(),
        // },
      ),
    );
  }
}
