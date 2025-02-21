import 'package:domain_entities/domain_entities.dart';
import 'package:quiz_repository/quiz_repository.dart';

class QuizRepository {
  const QuizRepository({required this.storage});
  final QuizStorage storage;

  Future<List<Quiz>> getAllQuizzes() async {
    try {
      return await storage.getAllQuizzes();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<User>> getAllUsers() async {
    try {
      return await storage.getAllUsers();
    } catch (e) {
      rethrow;
    }
  }
}
