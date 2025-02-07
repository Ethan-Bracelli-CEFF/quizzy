import 'package:flutter/material.dart';
import 'package:component_library/component_library.dart';
import 'package:provider/provider.dart';
import 'package:quiz_list/quiz_list.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget _showQuiz() {
    final state = context.watch<QuizListProvider>().state;

    if (state.status == QuizListStatus.initial) {
      return const Center(
        child: Row(
          children: [
            Text('Getting started...'),
            SizedBox(
              width: 10,
            ),
            CircularProgressIndicator(),
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
                    children: [
                      Text('Fetching Data...'),
                      SizedBox(
                        width: 10,
                      ),
                      CircularProgressIndicator(),
                    ],
                  )
                : ListView.separated(
                    itemBuilder: (context, index) => QuizItem(),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 30,
                        ),
                    itemCount: 10),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
}
