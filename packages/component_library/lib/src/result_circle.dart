import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultCircle extends StatelessWidget {
  const ResultCircle({required this.points, super.key});

  final int points;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      animation: true,
      animationDuration: 1000,
      radius: 200.0,
      lineWidth: 30.0,
      percent: points / 36,
      center: Text(
        '${(points / 36 * 100).roundToDouble()}%',
        style: TextStyle(color: Colors.white, fontSize: 50),
      ),
      progressColor: Colors.green,
      backgroundColor: Colors.red,
    );
  }
}
