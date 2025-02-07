import 'package:domain_entities/domain_entities.dart';

abstract class QuizStorage {
  Future<List<Quiz>> getAllQuizzes();
}
