import 'package:component_library/component_library.dart';
import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 100.0),
                child: QuestionTitleItem(question: question),
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => AnswerItem(
                    text: question.answers[index],
                    isCorrectAnswer:
                        index + 1 == question.rightAnswer ? true : false,
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

  void handleAnswerAndReveal(int clickedIndex, Question question) {
    if (clickedIndex == question.rightAnswer) {
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

    if (index < questions.length) {
      setState(() {
        this.index += 1;
        showAnswers = false;
      });
    } else {
      Navigator.of(context).pushReplacementNamed(ResultatPageScreen.routeName);
    }
  }
}
