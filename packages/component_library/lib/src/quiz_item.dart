import 'package:component_library/component_library.dart';
import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';

class QuizItem extends StatelessWidget {
  const QuizItem(
      {required this.quiz, required this.showDetail, note, liked, super.key})
      : note = note ?? 0,
        liked = liked ?? false;

  final int note;
  final bool liked;
  final Quiz quiz;
  final Function(String id) showDetail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDetail(quiz.id ?? ''),
      child: Container(
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 80, 80, 80),
          border:
              Border.all(color: liked ? Colors.pink : Colors.white, width: 2.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                AchievementItem(note: note),
                Text(
                  quiz.title,
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                ),
                Wrap(
                  spacing: 7,
                  runSpacing: 5,
                  children: [
                    for (int i = 0; i < quiz.tags.length; i++)
                      Tag(name: quiz.tags[i]),
                  ],
                ),
              ],
            ),
            Text(
              quiz.description,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
