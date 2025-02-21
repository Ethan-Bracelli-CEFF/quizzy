import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';
import 'package:provider/provider.dart';
import 'package:quiz_list/quiz_list.dart';
import 'package:quiz_list/src/screens/create_quiz_screen.dart';

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
      child: state.status == QuizListStatus.loading
          ? Center(
              child: Row(
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
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 17.0),
                    child: SearchsBar(click: (String value) {
                      context.read<QuizListProvider>().filterQuizzes(value);
                    }),
                  ),
                  // SizedBox(height: 30.0),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => QuizItem(
                        quiz: state.filtered[index],
                        showDetail: (id) => _showDetailQuizScreen(id),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 20,
                      ),
                      itemCount: state.filtered.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 70, 70, 70),
        toolbarHeight: 70.0,
        centerTitle: true,
        title: Text(
          'Quizzy',
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
      ),
      body: _showQuiz(),
      backgroundColor: Color.fromARGB(255, 18, 18, 18),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 70, 70, 70),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 28.0,
                  )),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CreateQuizScreen.routeName);
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 28.0,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28.0,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetailQuizScreen(String id) {
    Navigator.of(context).pushNamed(DetailPageScreen.routeName, arguments: id);
  }
}
