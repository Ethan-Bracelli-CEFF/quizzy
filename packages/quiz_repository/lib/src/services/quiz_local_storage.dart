import 'dart:convert';

import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/services.dart';
import 'package:quiz_repository/quiz_repository.dart';
import 'package:quiz_repository/src/mappers/question_local_model_to_domain.dart';

class QuizLocalStorage implements QuizStorage {
  @override
  Future<List<Quiz>> getAllQuizzes() async {
    try {
      final quizzes = <Quiz>[];
      final dataString = await rootBundle.loadString(
          'packages/quiz_repository/lib/src/assets/data/exemple.json');
      final Map<String, dynamic> json = jsonDecode(dataString);
      if (json['quizzes'] != null) {
        json['quizzes'].foEach((quizData) {
          final questions = <Question>[];
          quizData['questions'].foEach((questionData) {
            questions.add(
                QuestionLocalModel.fromJson(questionData).toDomainEntity());
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
