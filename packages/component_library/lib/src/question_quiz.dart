import 'package:flutter/material.dart';

class QuestionQuiz extends StatelessWidget {
  const QuestionQuiz({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          overflow: TextOverflow.clip,
          fontSize: 20.0,
        ),
      ),
    );
  }
}
