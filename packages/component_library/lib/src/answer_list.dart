import 'package:component_library/component_library.dart';
import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';

class AnswerList extends StatefulWidget {
  const AnswerList({required this.question, super.key});

  final Question question;

  @override
  State<AnswerList> createState() => _AnswerListState();
}

class _AnswerListState extends State<AnswerList> {
  var showAnswers = false;

  void revealAnswers() {
    setState(() {
      showAnswers = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => AnswerItem(
        text: widget.question.answers[index],
        isCorrectAnswer:
            index + 1 == widget.question.rightAnswer ? true : false,
        showAnswer: showAnswers,
        click: revealAnswers,
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 10.0),
      itemCount: widget.question.answers.length,
    );
  }
}
