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

  void _saveProgress({required int index, required String id}) {
    int points = context.read<QuizPoints>().points;
    int seed = context.read<QuizSeed>().seed;

    var progress =
        GameProgress(id: id, index: index, point: points, seed: seed);

    final user = context.read<UserListProvider>().userState.user;

    context
        .read<UserListProvider>()
        .addProgresss(progress, user.id as String, index);
    Navigator.of(context).pop();
  }

  var showAnswers = false;

  bool setup = false;
  int index = 0;
  int initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    List<Question> questions = data[0];
    String quizId = data[1];
    if (!setup) {
      index = data[2];
      initialIndex = index;
      setup = true;
    }
    int questionTotCount = data[3];

    int questionIndex = index - initialIndex;

    final question = questions[questionIndex];

    double percentage = index / questionTotCount;

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
          leading: IconButton(
            icon: Icon(
              Icons.home,
              size: 40,
            ),
            onPressed: () => _saveProgress(id: quizId, index: index),
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
                  "$index/$questionTotCount",
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

    if (question.answers[clickedIndex - 1].correct) {
      context.read<QuizPoints>().points += 1;
    }

    setState(() {
      showAnswers = true;
    });
  }

  void _nextQuestion(BuildContext context, int index) {
    final data = ModalRoute.of(context)?.settings.arguments as List<dynamic>;

    final List<Question> questions = data[0];
    final String id = data[1];
    int questionTotCount = data[3];
    final user = context.read<UserListProvider>().userState.user;
    final quiz = context.read<QuizListProvider>().findQuizById(id);
    final progress =
        context.read<UserListProvider>().getQuizProgression(quiz, user);

    if (index + 1 < questionTotCount) {
      setState(() {
        this.index += 1;
        showAnswers = false;
        answered = false;
      });
    } else {
      context
          .read<UserListProvider>()
          .deleteProgress(user.id as String, progress as GameProgress);
      final points = context.read<QuizPoints>().points;
      double percentage = points / questions.length;
      void updateAchievement() {
        for (var a in user.achievement) {
          if (a.id == id && a.hightscore < points) {
            context.read<UserListProvider>().updateAchievement(
                  achievement: Achievement(
                      id: id,
                      star: (percentage * 5).floor(),
                      hightscore: points),
                  user: user,
                  quizId: a.id,
                );
            return;
          } else if (a.id == id && a.hightscore >= points) {
            return;
          }
        }

        context.read<UserListProvider>().addAchievement(
              achievement: Achievement(
                  id: id, star: (percentage * 5).floor(), hightscore: points),
              user: user,
            );
      }

      updateAchievement();

      Navigator.of(context).pushReplacementNamed(ResultatPageScreen.routeName,
          arguments: [questions, id, questionTotCount]);
    }
  }
}
