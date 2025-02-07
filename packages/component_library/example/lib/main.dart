import 'package:component_library/component_library.dart';
// import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Storybook(
      initialStory: 'Screens/HomePage',
      stories: [
        Story(
          name: 'Widgets/QuizItem',
          description: 'La tuile d\'un quiz',
          builder: (context) => const QuizItem(),
        ),
        Story(
          name: 'Screens/HomePage',
          description: 'La page d\'accueil',
          builder: (context) => const HomePage(),
        ),
      ],
      wrapperBuilder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quizzy',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          body: Center(child: child),
        ),
      ),
    );
  }
}
