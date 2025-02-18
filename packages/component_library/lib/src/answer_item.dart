import 'package:flutter/material.dart';

class AnswerItem extends StatefulWidget {
  const AnswerItem(
      {required this.text, required this.isCorrectAnswer, super.key});

  final String text;
  final bool isCorrectAnswer;

  @override
  State<AnswerItem> createState() => _AnswerItemState();
}

class _AnswerItemState extends State<AnswerItem> {
  bool showAnswer = false;

  revealAnswer() {
    setState(() {
      showAnswer = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => revealAnswer(),
      style: ButtonStyle(
        backgroundColor: showAnswer == false
            ? WidgetStatePropertyAll(Colors.grey.shade800)
            : widget.isCorrectAnswer
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
          widget.text,
          style: const TextStyle(fontSize: 25.0, color: Colors.white),
        ),
      ),
    );
  }
}
