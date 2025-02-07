import 'package:component_library/component_library.dart';
import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';

class QuizDetail extends StatelessWidget {
  const QuizDetail({required this.quiz, super.key});

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 80, 80, 80),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quiz.title,
                style: const TextStyle(color: Colors.white, fontSize: 40),
              ),
              const SizedBox(height: 5),
              Wrap(
                spacing: 7,
                children: [
                  for (int i = 0; i < quiz.tags.length; i++)
                    Tag(name: quiz.tags[i])
                ],
              ),
              const SizedBox(height: 40),
              Text(
                quiz.description,
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
