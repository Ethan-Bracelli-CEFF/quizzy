import 'dart:isolate';

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
    _fetchUsers();
  }

  final List<String> categories = [
    "Tous",
    "Culture G",
    "Géographie",
    "Histoire",
    "Sport",
    "Informatique",
    "Culture Médiatique",
    "Autres"
  ];

  String selectedCategorie = "Tous";

  _fetchQuizes() {
    if (context.read<QuizListProvider>().state.quizzes.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<QuizListProvider>().fetchAndSetQuizes();
      });
    }
  }

  _fetchUsers() {
    if (context.read<UserListProvider>().state.users.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<UserListProvider>().fetchAndSetUsers();
      });
    }
  }

  void _updateCategories({required int categoryIndex}) {
    String category = categories[categoryIndex];
    selectedCategorie = category;

    context.read<QuizListProvider>().filterCategories(category);
  }

  Widget _categoryButton(
      {required String value,
      required Function(int index) updateCategories,
      required int index}) {
    return TextButton(
      onPressed: () => updateCategories(index),
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(color: Colors.grey),
          ),
        ),
        backgroundColor: selectedCategorie == value
            ? WidgetStatePropertyAll(Colors.grey)
            : WidgetStatePropertyAll(Colors.transparent),
      ),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Text(
          value,
          style: TextStyle(
            color: selectedCategorie == value ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _showQuiz() {
    final state = context.watch<QuizListProvider>().state;
    final user = context.watch<UserListProvider>().userState;

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
              padding: const EdgeInsets.all(17.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: SearchsBar(click: (String value) {
                      context.read<QuizListProvider>().filterQuizzes(value);
                    }),
                  ),
                  SizedBox(height: 5.0),
                  Wrap(
                    runSpacing: 5.0,
                    spacing: 10.0,
                    children: [
                      for (int i = 0; i < categories.length; i++)
                        _categoryButton(
                          value: categories[i],
                          updateCategories: (int index) =>
                              _updateCategories(categoryIndex: index),
                          index: i,
                        ),
                    ],
                  ),
                  SizedBox(height: 30.0),
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
