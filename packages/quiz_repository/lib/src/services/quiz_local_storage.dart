import 'dart:convert';

import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/services.dart';
import 'package:quiz_repository/quiz_repository.dart';

class QuizLocalStorage implements QuizStorage {
  @override
  Future<List<Quiz>> getAllQuizzes() async {
    try {
      final quizzes = <Quiz>[];

      final dataString = await rootBundle.loadString(
          'packages/quiz_repository/lib/src/assets/data/questions.json');

      final Map<String, dynamic> json = jsonDecode(dataString);

      if (json['questionnaires'] != null) {
        json['questionnaires'].forEach((quizData) {
          final questions = <Question>[];
          quizData['questions'].forEach((questionData) {
            final responses = <Response>[];
            questionData['responses'].forEach((responseData) {
              responses.add(
                  ResponseLocalModel.fromJson(responseData).toDomainEntity());
            });
            questions.add(QuestionLocalModel.fromJson(questionData)
                .toDomainEntity(responses));
          });
          quizzes
              .add(QuizLocalModel.fromJson(quizData).toDomainEntity(questions));
        });
      }
      return quizzes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<User>> getAllUsers() async {
    try {
      final users = <User>[];

      final dataString = await rootBundle.loadString(
          'packages/quiz_repository/lib/src/assets/data/questions.json');

      final Map<String, dynamic> json = jsonDecode(dataString);

      if (json['utilisateurs'] != null) {
        json['utilisateurs'].forEach((userData) {
          List<GameProgress> gameProgress = [];
          List<Achievement> achievement = [];
          userData['in_progress'].forEach((gameProgressData) {
            gameProgress.add(GameProgressLocalModel.fromJson(gameProgressData)
                .toDomainEntity());
          });
          userData['achievements'].forEach((achievementData) {
            achievement.add(AchievementLocalModel.fromJson(achievementData)
                .toDomainEntity());
          });
          users.add(UserLocalModel.fromJson(userData)
              .toDomainEntity(gameProgress, achievement));
        });
      }
      return users;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Quiz> addQuiz(Quiz quiz) {
    // TODO: implement addQuiz
    throw UnimplementedError();
  }

  @override
  Future<User> addUser(User user) {
    // TODO: implement addUser
    throw UnimplementedError();
  }

  @override
  Future<void> deleteQuiz(Quiz quiz) {
    // TODO: implement deleteQuiz
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(User user) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<void> updateQuiz(Quiz quiz) {
    // TODO: implement updateQuiz
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(User user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<void> addAchievement(Achievement achievement, String id, int index) {
    // TODO: implement addAchievement
    throw UnimplementedError();
  }

  @override
  Future<void> addLike(User user, String like, int index) {
    // TODO: implement addLike
    throw UnimplementedError();
  }

  @override
  Future<void> deleteLike(User user, int index) {
    // TODO: implement deleteLike
    throw UnimplementedError();
  }

  @override
  Future<void> addInterest(User user, String interest, int index) {
    // TODO: implement addInterest
    throw UnimplementedError();
  }

  @override
  Future<void> deleteInterest(User user, List<String> interests) {
    // TODO: implement deleteInterest
    throw UnimplementedError();
  }

  @override
  Future<void> addProgress(GameProgress progress, String userId, int index) {
    // TODO: implement addProgress
    throw UnimplementedError();
  }

  @override
  Future<List<GameProgress>> getAllProgressByUser(User user) {
    // TODO: implement getAllProgressByUser
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProgress(User user, GameProgress progress) {
    // TODO: implement deleteProgress
    throw UnimplementedError();
  }
}
