import 'package:component_library/component_library.dart';
import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_list/quiz_list.dart';

class UserPageScreen extends StatefulWidget {
  static const routeName = 'user_screen';

  const UserPageScreen({super.key});

  @override
  State<UserPageScreen> createState() => _UserPageScreenState();
}

class _UserPageScreenState extends State<UserPageScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<UserListProvider>().userState.user;
    final quizzes =
        context.read<QuizListProvider>().findQuizzesByAuthor(user.username);

    int pointsTot = 0;
    user.achievement.forEach((v) {
      pointsTot += v.star;
    });

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17.0),
        child: Column(
          children: [
            SizedBox(
              height: 17,
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 50.0,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.username,
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                    Text(
                        '${user.achievement.length} quiz joués | $pointsTot étoiles gagnées',
                        style: TextStyle(color: Colors.white, fontSize: 17.0))
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Divider(),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => Row(
                  children: [
                    Expanded(
                        child: QuizItem(
                            quiz: quizzes[index],
                            showDetail: (id) {
                              Navigator.of(context).pushNamed(
                                  DetailPageScreen.routeName,
                                  arguments: id);
                            })),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                CreateQuizScreen.routeName,
                                arguments: quizzes[index].id);
                          },
                          icon:
                              Icon(Icons.edit, color: Colors.blue, size: 35.0),
                        ),
                        SizedBox(height: 10.0),
                        IconButton(
                          onPressed: () {},
                          icon:
                              Icon(Icons.delete, color: Colors.red, size: 35.0),
                        ),
                      ],
                    )
                  ],
                ),
                separatorBuilder: (context, index) => SizedBox(height: 15),
                itemCount: quizzes.length,
              ),
            )
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 18, 18, 18),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 70, 70, 70),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(HomePageScreen.routeName);
                  },
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
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(UserPageScreen.routeName);
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 28.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
