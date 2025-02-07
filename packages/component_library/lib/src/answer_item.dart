import 'package:flutter/material.dart';

class AnswerItem extends StatelessWidget {
  const AnswerItem({required this.text, super.key});

  final String text;

  // TODO: Finir le composant
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.grey.shade800),
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
