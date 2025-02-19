import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({required this.score, required this.maxScore, super.key});

  final int score;
  final int maxScore;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          toolbarHeight: 100,
          backgroundColor: const Color.fromRGBO(70, 70, 70, 70),
          centerTitle: true,
          title: const Text(
            'Quizzy',
            style: TextStyle(color: Colors.white, fontSize: 60),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularPercentIndicator(
                radius: 200.0,
                lineWidth: 30.0,
                percent: widget.score / widget.maxScore,
                center: Text(
                  '${(widget.score / widget.maxScore * 100).roundToDouble()}%',
                  style: TextStyle(color: Colors.white, fontSize: 50),
                ),
                progressColor: Colors.green,
                backgroundColor: Colors.red,
              ),
              SizedBox(height: 50),
              Text(
                'Votre score : ${widget.score} / ${widget.maxScore}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27.0,
                ),
              )
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromRGBO(70, 70, 70, 70),
          child: IconButton(
            color: Colors.white,
            icon: const Icon(
              Icons.arrow_forward,
              size: 24.0,
            ),
            onPressed: () {},
          ),
        ));
  }
}
