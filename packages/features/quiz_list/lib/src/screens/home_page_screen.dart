import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';
import 'package:provider/provider.dart';
import 'package:quiz_list/quiz_list.dart';

class HomePageScreen extends StatefulWidget {
  static const routeName = 'home_screen';

  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    super.initState();
    _fetchQuizes();
  }

  _fetchQuizes() {
    if (context.read<QuizListProvider>().state.quizzes.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<QuizListProvider>().fetchAndSetQuizes();
      });
    }
  }

  Widget _showQuiz() {
    final state = context.watch<QuizListProvider>().state;

    if (state.status == QuizListStatus.initial) {
      return const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Getting started...',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      );
    }

    return Container(
      color: Color.fromARGB(255, 18, 18, 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 70,
          ),
          Expanded(
            child: state.status == QuizListStatus.loading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Fetching Data...',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SearchsBar(click: (String value) {
                        context.read<QuizListProvider>().filterQuizzes(value);
                      }),
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => QuizItem(
                                  quiz: state.quizzes[index],
                                  showDetail: (id) => _showDetailQuizScreen(id),
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 30,
                                ),
                            itemCount: state.quizzes.length),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        toolbarHeight: 100,
        backgroundColor: const Color.fromRGBO(70, 70, 70, 70),
        centerTitle: true,
        title: Text(
          'Quizzy',
          style: TextStyle(color: Colors.white, fontSize: 60),
        ),
      ),
      body: _showQuiz(),
      backgroundColor: Color.fromARGB(255, 18, 18, 18),
    );
  }

  void _showDetailQuizScreen(String id) {
    Navigator.of(context).pushNamed(DetailPageScreen.routeName, arguments: id);
  }
}
