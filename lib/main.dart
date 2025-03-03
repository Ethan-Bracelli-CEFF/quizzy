import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_list/quiz_list.dart';
import 'package:quiz_repository/quiz_repository.dart';

void main() {
  runApp(const Quizzy());
}

//TODO : General Error
//Update Achievement didn't work every time. The first time it works
//ajout d'une question dans quiz
//Le gameprogress ne se met pas a jour
class Quizzy extends StatelessWidget {
  const Quizzy({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<QuizLocalStorage>(
          create: (context) => QuizLocalStorage(),
        ),
        Provider<QuizRemoteStorage>(
          create: (context) => QuizRemoteStorage(),
        ),
        Provider<QuizRepository>(
          create: (context) => QuizRepository(
            storage: context.read<QuizRemoteStorage>(),
          ),
        ),
        Provider<QuizPoints>(
          create: (context) => QuizPoints(),
        ),
        Provider<QuizSeed>(
          create: (context) => QuizSeed(),
        ),
        ChangeNotifierProvider<QuizListProvider>(
          create: (context) => QuizListProvider(
            repository: context.read<QuizRepository>(),
          ),
        ),
        ChangeNotifierProvider<UserListProvider>(
          create: (context) => UserListProvider(
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
        routes: {
          '/': (context) => const HomePageScreen(),
          DetailPageScreen.routeName: (context) => const DetailPageScreen(),
          QuestionPageScreen.routeName: (context) => const QuestionPageScreen(),
          ResultatPageScreen.routeName: (context) => const ResultatPageScreen(),
          CreateQuizScreen.routeName: (context) => CreateQuizScreen(),
          UserPageScreen.routeName: (context) => UserPageScreen()
        },
      ),
    );
  }
}
