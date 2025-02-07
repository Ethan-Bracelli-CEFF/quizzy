import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
      body: Container(
        color: Color.fromARGB(255, 18, 18, 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 70,
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => QuizItem(),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 30,
                      ),
                  itemCount: 10),
            ),
          ],
        ),
      ),
    );
  }
}
