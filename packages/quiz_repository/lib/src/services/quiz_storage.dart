import 'package:domain_entities/domain_entities.dart';

abstract class QuizStorage {
  Future<List<Quiz>> getAllQuizzes();
  Future<List<User>> getAllUsers();

  Future<Quiz> addQuiz(Quiz quiz);
  Future<void> updateQuiz(Quiz quiz);
  Future<void> deleteQuiz(Quiz quiz);

  Future<User> addUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(User user);

  Future<void> addAchievement(
      Achievement achievement, String userId, int index);
}
