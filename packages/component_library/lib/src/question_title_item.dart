import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';

class QuestionTitleItem extends StatelessWidget {
  const QuestionTitleItem({required this.question, super.key});

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(35.0),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      child: Text(question.title),
    );
  }
}
