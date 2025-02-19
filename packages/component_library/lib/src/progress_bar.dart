import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({required this.points, super.key});

  final int points;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: LinearPercentIndicator(
        animation: true,
        animateFromLastPercent: true,
        lineHeight: 40.0,
        animationDuration: 500,
        percent: points / 36,
        barRadius: Radius.circular(17.0),
        center: Text(
          "$points/36",
          style: TextStyle(fontSize: 30),
        ),
        progressColor: Colors.blue.shade400,
      ),
    );
  }
}
