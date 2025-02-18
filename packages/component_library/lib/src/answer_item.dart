import 'package:flutter/material.dart';

class AnswerItem extends StatelessWidget {
  const AnswerItem(
      {required this.text,
      required this.isCorrectAnswer,
      required this.showAnswer,
      required this.click,
      required this.index,
      super.key});

  final String text;
  final bool isCorrectAnswer;
  final bool showAnswer;
  final int index;

  final void Function(int index) click;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => click(index),
      style: ButtonStyle(
        backgroundColor: showAnswer == false
            ? WidgetStatePropertyAll(Colors.grey.shade800)
            : isCorrectAnswer
                ? const WidgetStatePropertyAll(Colors.green)
                : const WidgetStatePropertyAll(Colors.red),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 25.0, color: Colors.white),
        ),
      ),
    );
  }
}
