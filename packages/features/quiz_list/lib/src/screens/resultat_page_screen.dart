import 'package:flutter/material.dart';
import 'package:quiz_list/quiz_list.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ResultatPageScreen extends StatefulWidget {
  static const routeName = 'resultat_screen';

  const ResultatPageScreen({super.key});

  @override
  State<ResultatPageScreen> createState() => _ResultatPageScreenState();
}

class _ResultatPageScreenState extends State<ResultatPageScreen> {
  int score =

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
          child: CircularPercentIndicator(
            radius: 200.0,
            lineWidth: 30.0,
            percent: widget.score / 100,
            center: Text(
              '${widget.score}%',
              style: TextStyle(color: Colors.white, fontSize: 50),
            ),
            progressColor: Colors.green,
            backgroundColor: Colors.red,
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
          onPressed: () =>
              Navigator.of(context).pushNamed(HomePageScreen.routeName),
        ),
      ),
    );
  }
}
