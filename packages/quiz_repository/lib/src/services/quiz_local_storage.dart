import 'dart:convert';

import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:quiz_repository/quiz_repository.dart';

class QuizLocalStorage implements QuizStorage {
  final logger = Logger();

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
}
