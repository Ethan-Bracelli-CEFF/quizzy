import 'package:domain_entities/domain_entities.dart';

abstract class QuizStorage {
  Future<List<Quiz>> getAllQuizzes();
  Future<Quiz> addQuiz(Quiz quiz);
  Future<void> updateQuiz(Quiz quiz);
  Future<void> deleteQuiz(Quiz quiz);
  Future<List<User>> getAllUsers();
  Future<User> addUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(User user);
}
