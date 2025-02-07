import 'package:component_library/component_library.dart';
import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';

class QuizItem extends StatelessWidget {
  const QuizItem({required this.quiz, super.key});

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 25.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 80, 80, 80),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 5,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            alignment: WrapAlignment.spaceBetween,
            runAlignment: WrapAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quiz.title,
                style: const TextStyle(color: Colors.white, fontSize: 25),
              ),
              Wrap(
                spacing: 7,
                runSpacing: 5,
                children: [
                  for (int i = 0; i < quiz.tags.length; i++)
                    Tag(name: quiz.tags[i].toLowerCase()),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            quiz.description,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
