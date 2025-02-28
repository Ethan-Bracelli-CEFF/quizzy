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

  Future<Quiz> addQuiz(Quiz quiz) async {
    try {
      return await storage.addQuiz(quiz);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateQuiz(Quiz quiz) async {
    try {
      return await storage.updateQuiz(quiz);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteQuiz(Quiz quiz) async {
    try {
      return await storage.deleteQuiz(quiz);
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

  Future<User> addUser(User user) async {
    try {
      return await storage.addUser(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(User user) async {
    try {
      return await storage.updateUser(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(User user) async {
    try {
      return await storage.deleteUser(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addAchievement(
      Achievement achievement, String userId, int index) async {
    try {
      await storage.addAchievement(achievement, userId, index);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addLike(User user, String like, int index) async {
    try {
      await storage.addLike(user, like, index);
    } catch (e) {
      rethrow;
    }
  }
}
