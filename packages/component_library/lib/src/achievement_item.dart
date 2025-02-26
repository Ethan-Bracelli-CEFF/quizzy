import 'package:flutter/material.dart';

class AchievementItem extends StatelessWidget {
  const AchievementItem({required this.note, size, super.key})
      : size = size ?? 32.0;

  factory AchievementItem.fromPercentage(double percentage, {size}) {
    int note = 0;

    while (percentage >= 0.2) {
      note++;
      percentage = double.parse((percentage - 0.2).toStringAsFixed(1));
    }

    return AchievementItem(note: note, size: size);
  }

  final int note;
  final double size;

  Color getNoteColor(int note) {
    switch (note) {
      case 5:
        return Colors.yellow;
      case 4:
        return Colors.green;
      case 3:
        return Colors.yellow;
      case 2:
        return Colors.grey;
      case 1:
        return Colors.brown;
      default:
        return Colors.white24;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      note >= 5 ? Icons.emoji_events : Icons.star,
      size: size,
      color: getNoteColor(note),
      shadows: [
        note > 0
            ? Shadow(
                color: Colors.black87, offset: Offset(0, 1.5), blurRadius: 1.5)
            : Shadow()
      ],
    );
  }
}
