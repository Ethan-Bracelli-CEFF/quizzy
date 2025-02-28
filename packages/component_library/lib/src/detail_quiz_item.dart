import 'package:component_library/component_library.dart';
import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';

class DetailQuizItem extends StatefulWidget {
  const DetailQuizItem(
      {required this.quiz,
      required this.onLike,
      required this.onDislike,
      note,
      liked,
      super.key})
      : note = note ?? 0,
        liked = liked ?? false;

  final Quiz quiz;
  final int note;
  final bool liked;
  final Function(String id) onLike;
  final Function(String id) onDislike;

  @override
  State<DetailQuizItem> createState() => _DetailQuizItemState();
}

class _DetailQuizItemState extends State<DetailQuizItem> {
  bool? liked;

  @override
  Widget build(BuildContext context) {
    liked ??= widget.liked;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 80, 80, 80),
        border: Border.all(color: Colors.white, width: 2.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.quiz.title,
                    style: const TextStyle(color: Colors.white, fontSize: 35),
                    overflow: TextOverflow.clip,
                  ),
                ),
                IconButton(
                    iconSize: 30.0,
                    onPressed: () {
                      liked!
                          ? widget.onDislike(widget.quiz.id!)
                          : widget.onLike(widget.quiz.id!);
                      setState(() {
                        liked = !liked!;
                      });
                    },
                    icon: liked!
                        ? Icon(
                            Icons.favorite,
                            color: Colors.pink,
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ))
              ],
            ),
            const SizedBox(height: 5),
            Wrap(
              spacing: 7,
              runSpacing: 5.0,
              children: [
                for (int i = 0; i < widget.quiz.tags.length; i++)
                  Tag(name: widget.quiz.tags[i])
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                for (int i = 0; i < 5; i++)
                  i < widget.note
                      ? AchievementItem(note: widget.note)
                      : AchievementItem(note: 0),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.account_circle,
                  size: 24.0,
                  color: Colors.white70,
                ),
                SizedBox(width: 7.0),
                Text(
                  widget.quiz.creator,
                  style: TextStyle(color: Colors.white, fontSize: 17.0),
                ),
              ],
            ),
            Text(
              '${widget.quiz.questions.length} questions',
              style: TextStyle(color: Colors.white, fontSize: 17.0),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                widget.quiz.description,
                style: const TextStyle(color: Colors.white70),
              ),
            )
          ],
        ),
      ),
    );
  }
}
