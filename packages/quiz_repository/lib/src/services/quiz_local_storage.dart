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
          'packages/quiz_repository/lib/src/assets/data/questionnaires.json');

      final Map<String, dynamic> json = jsonDecode(dataString);

      if (json['questionnaires'] != null) {
        json['questionnaires'].forEach((quizData) {
          final questions = <Question>[];
          quizData['questions'].forEach((questionData) {
            questions.add(
                QuestionLocalModel.fromJson(questionData).toDomainEntity());
          });
          quizzes
              .add(QuizLocalModel.fromJson(quizData).toDomainEntity(questions));
        });
      }
      // TODO: Delete Logger
      logger.w('Quizzes number: ${quizzes.length}');
      if (quizzes.isNotEmpty) {
        logger.w(quizzes[0].toString());
      }
      return quizzes;
    } catch (e) {
      logger.w(e);
      rethrow;
    }
  }
}
