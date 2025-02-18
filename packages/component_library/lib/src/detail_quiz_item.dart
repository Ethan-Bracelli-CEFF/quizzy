import 'package:component_library/component_library.dart';
import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';

class DetailQuizItem extends StatelessWidget {
  const DetailQuizItem({required this.quiz, super.key});

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 80, 80, 80),
        border: Border.all(color: Colors.white, width: 2.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: Text(
                quiz.title,
                style: const TextStyle(color: Colors.white, fontSize: 35),
              ),
            ),
            const SizedBox(height: 5),
            Wrap(
              spacing: 7,
              children: [
                for (int i = 0; i < quiz.tags.length; i++)
                  Tag(name: quiz.tags[i])
              ],
            ),
            const SizedBox(height: 35),
            Text(
              quiz.description,
              style: const TextStyle(color: Colors.white70),
            )
          ],
        ),
      ),
    );
  }
}
