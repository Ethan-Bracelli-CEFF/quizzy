import 'package:component_library/component_library.dart';
import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:quiz_list/quiz_list.dart';

class QuestionPageScreen extends StatefulWidget {
  static const routeName = 'question_page';

  const QuestionPageScreen({super.key});

  @override
  State<QuestionPageScreen> createState() => _QuestionPageScreenState();
}

class _QuestionPageScreenState extends State<QuestionPageScreen> {
  Widget body(Question question) {
    return Center(
      child: Text(
        question.title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  var showAnswers = false;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final quiz = context.read<QuizListProvider>().findQuizById(id);
    final questions = quiz.questions;

    final question = questions[index];

    double percentage = index / questions.length;

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
        body: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            children: [
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 37,
                animation: true,
                animateFromLastPercent: true,
                lineHeight: 40.0,
                animationDuration: 500,
                percent: percentage,
                barRadius: Radius.circular(17.0),
                center: Text(
                  "$index/${questions.length}",
                  style: TextStyle(fontSize: 30),
                ),
                progressColor: Colors.blue.shade400,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 100.0),
                child: QuestionTitleItem(question: question),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => AnswerItem(
                    text: question.answers[index].text,
                    isCorrectAnswer: question.answers[index].correct,
                    showAnswer: showAnswers,
                    click: (index) => handleAnswerAndReveal(index, question),
                    index: index + 1,
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20.0),
                  itemCount: question.answers.length,
                ),
              )
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 18, 18, 18),
        bottomNavigationBar: showAnswers
            ? BottomAppBar(
                color: const Color.fromRGBO(70, 70, 70, 70),
                child: IconButton(
                  color: Colors.white,
                  icon: const Icon(
                    Icons.arrow_forward,
                    size: 24.0,
                  ),
                  onPressed: () => _nextQuestion(context, index),
                ),
              )
            : null);
  }

  bool answered = false;

  void handleAnswerAndReveal(int clickedIndex, Question question) {
    if (answered) {
      return;
    }

    answered = true;

    if (question.answers[clickedIndex].correct) {
      context.read<QuizPoints>().points += 1;
    }

    setState(() {
      showAnswers = true;
    });
  }

  void _nextQuestion(BuildContext context, int index) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final quiz = context.read<QuizListProvider>().findQuizById(id);
    final questions = quiz.questions;

    if (index + 1 < questions.length) {
      setState(() {
        this.index += 1;
        showAnswers = false;
        answered = false;
      });
    } else {
      Navigator.of(context)
          .pushReplacementNamed(ResultatPageScreen.routeName, arguments: quiz);
    }
  }
}
