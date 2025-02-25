import 'dart:convert';
import 'dart:io';

import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/foundation.dart';
import 'package:quiz_repository/quiz_repository.dart';

import 'package:http/http.dart' as http;

class QuizRemoteStorage implements QuizStorage {
  static const url = 'http://127.0.0.1:9000';
  static const dbName = '?ns=cie-295-a3703-default-rtdb';

  QuizRemoteStorage({@visibleForTesting http.Client? client})
      : _client = client ?? http.Client();

  final http.Client _client;
  final quizzes = <Quiz>[];
  final users = <User>[];

  @override
  Future<List<Quiz>> getAllQuizzes() async {
    try {
      final parsedUrl = Uri.parse('$url/questionnaires.json$dbName');

      final response = await _client.get(parsedUrl);

      if (response.statusCode / 100 != 2) {
        throw HttpException('${response.statusCode}');
      }

      final data = jsonDecode(response.body);

      if (data['questionnaires'] != null) {
        data['questionnaires'].forEach((quizId, quizData) {
          final questions = <Question>[];
          quizData['questions'].forEach((questionData) {
            final responses = <Response>[];
            questionData['responses'].forEach((responseData) {
              responses.add(
                  ResponseRemoteModel.fromJson(responseData).toDomainEntity());
            });
            questions.add(QuestionRemoteModel.fromJson(questionData)
                .toDomainEntity(responses));
          });
          //TODO : Enlever toString quand BD id sont des string
          quizzes.add(QuizRemoteModel.fromJson(quizData)
              .toDomainEntity(quizId.toString(), questions));
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
      final parsedUrl = Uri.parse('$url/utilisateurs.json$dbName');

      final response = await _client.get(parsedUrl);

      if (response.statusCode / 100 != 2) {
        throw HttpException('${response.statusCode}');
      }

      final data = jsonDecode(response.body);

      if (data['utilisateurs'] != null) {
        data['utilisateurs'].forEach((userId, userData) {
          List<GameProgress> gameProgress = [];
          List<Achievement> achievement = [];
          userData['in_progress'].forEach((gameProgressData) {
            gameProgress.add(GameProgressRemoteModel.fromJson(gameProgressData)
                .toDomainEntity());
          });
          userData['achievements'].forEach((achievementData) {
            achievement.add(AchievementRemoteModel.fromJson(achievementData)
                .toDomainEntity());
          });
          //TODO : Enlever toString quand BD id sont des string
          users.add(UserRemoteModel.fromJson(userData)
              .toDomainEntity(userId.toString(), gameProgress, achievement));
        });
      }
      return users;
    } catch (e) {
      rethrow;
    }
  }
}
