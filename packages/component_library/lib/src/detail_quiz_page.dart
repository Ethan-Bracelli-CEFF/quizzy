import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class DetailQuizPage extends StatelessWidget {
  const DetailQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey,
          child: const Text('Quizzy', textAlign: TextAlign.center),
        ),
        Container(
          color: Colors.black,
          child: Column(
            children: [
              DetailQuizItem(),
            ],
          ),
        ),
      ],
    );
  }
}
