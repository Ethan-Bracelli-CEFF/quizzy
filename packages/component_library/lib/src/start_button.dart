import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  const StartButton({required this.click, super.key});

  final Function() click;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => click(),
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.green.shade400),
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Text(
          'Start',
          style: TextStyle(fontSize: 35.0, color: Colors.white),
        ),
      ),
    );
  }
}
