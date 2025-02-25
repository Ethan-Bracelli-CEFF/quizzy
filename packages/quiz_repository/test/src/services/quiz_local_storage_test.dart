import 'dart:math';

import 'package:domain_entities/domain_entities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_repository/quiz_repository.dart';

void main() {
  group('getAllQuizzes', () {
    late Map<String, dynamic> responseData;
    late Map<String, dynamic> questionData;
    late Map<String, dynamic> quizData;
    late Question question;
    late Response response;
    late Quiz quiz;

    setUp(() {
      responseData = {"text": "Ewan"};
      questionData = {
        "title": "Quel est le nom de famille de Fabian?",
        "responses": [
          {"text": "Ewan"},
          {"text": "Quentin", "correct": true},
          {"text": "Martim"},
          {"text": "Le Hockey"},
        ]
      };
      quizData = {
        "id": "quiz1",
        "creator": "Fabrioche",
        "title": "Étudiants de la classe ICH-2DEV",
        "description": "Connaissez vous les étudiants de la classe ICH-2DEV?",
        "tags": ["#Etudiant", "#Ecole"],
        "questions": [
          {
            "responses": [
              {"text": "5"},
              {"text": "6"},
              {"text": "7"},
              {"correct": true, "text": "8"}
            ],
            "title":
                "De combien de joueurs doit au minimum se composer une équipe de hockey pour ne pas devoir faire forfait?"
          },
          {
            "responses": [
              {"text": "USA"},
              {"text": "Grèce"},
              {"correct": true, "text": "France"},
              {"text": "Chine"}
            ],
            "title": "De quel pays sont originaire les JO moderne?"
          }
        ]
      };
      response = Response(text: 'Ewan', correct: false);
      question = Question(
        title: 'Quel est le nom de famille de Fabian?',
        answers: [response],
      );
      quiz = Quiz(
          id: 'quiz1',
          creator: 'Fabrioche',
          title: 'Étudiants de la classe ICH-2DEV',
          description: 'Connaissez vous les étudiants de la classe ICH-2DEV?',
          tags: ['#Etudiant', '#Ecole'],
          questions: [question]);
    });

    test('ResponseLocalModel.fromJson return a Response', () {
      expect(ResponseRemoteModel.fromJson(responseData).toDomainEntity(),
          isA<Response>());
    });

    test('ResponseLocalModel.fromJson return a Response with good values', () {
      expect(
          ResponseLocalModel.fromJson(responseData).toDomainEntity(), response);
    });

    test('QuestionLocalModel.fromJson return a Question', () {
      expect(
          QuestionLocalModel.fromJson(questionData).toDomainEntity([response]),
          isA<Question>());
    });

    test('QuestionLocalModel.fromJson return a Question with good values', () {
      expect(
          QuestionLocalModel.fromJson(questionData).toDomainEntity([response]),
          question);
    });

    test('QuizLocalModel.fromJson return a Quiz', () {
      expect(QuizLocalModel.fromJson(quizData).toDomainEntity([question]),
          isA<Quiz>());
    });

    test('QuizLocalModel.fromJson return a Quiz with good values', () {
      expect(
          QuizLocalModel.fromJson(quizData).toDomainEntity([question]), quiz);
    });
  });

  group('getAllUsers', () {
    late Map<String, dynamic> achievementData;
    late Map<String, dynamic> gameProgressData;
    late Map<String, dynamic> userData;
    late Achievement achievement;
    late GameProgress gameProgress;
    late User user;

    setUp(() {
      achievementData = {"id": "-asdkjfhb", "star": 4, "highscore": 29};
      gameProgressData = {"id": "-asdkjfhb", "index": 3, "point": 5, "seed": 2};
      userData = {
        "username": "Fabrioche",
        "id": "hey",
        "interests": ["foot", "informatique"],
        "likes": ["-asdkjhus"],
        "in_progress": [
          {"id": "-asdkjfhb", "index": 3, "point": 5, "seed": 2}
        ],
        "achievements": [
          {"id": "-asdkjfhb", "star": 4, "highscore": 29}
        ]
      };
      achievementData = {"id": "-asdkjfhb", "star": 4, "highscore": 29};
      achievement = Achievement(id: '-asdkjfhb', star: 4, hightscore: 29);
      gameProgress = GameProgress(id: '-asdkjfhb', index: 3, point: 5, seed: 2);
      user = User(
          username: 'Fabrioche',
          id: 'hey',
          interests: ['foot', 'informatique'],
          likes: ['-asdkjhus'],
          gameProgress: [gameProgress],
          achievement: [achievement]);
    });

    test('AchievementLocalModel.fromJson return a Achievement', () {
      expect(AchievementLocalModel.fromJson(achievementData).toDomainEntity(),
          isA<Achievement>());
    });

    test('AchievementLocalModel.fromJson return a Achievement with good values',
        () {
      expect(AchievementLocalModel.fromJson(achievementData).toDomainEntity(),
          achievement);
    });

    test('GameProgressLocalModel.fromJson return a GameProgress', () {
      expect(GameProgressLocalModel.fromJson(gameProgressData).toDomainEntity(),
          isA<GameProgress>());
    });

    test(
        'GameProgressLocalModel.fromJson return a GameProgress with good values',
        () {
      expect(GameProgressLocalModel.fromJson(gameProgressData).toDomainEntity(),
          gameProgress);
    });

    test('UserLocalModel.fromJson return a User', () {
      expect(
          UserLocalModel.fromJson(userData)
              .toDomainEntity([gameProgress], [achievement]),
          isA<User>());
    });

    test('UserLocalModel.fromJson return a User with good values', () {
      expect(
          UserLocalModel.fromJson(userData)
              .toDomainEntity([gameProgress], [achievement]),
          user);
    });
  });
}
