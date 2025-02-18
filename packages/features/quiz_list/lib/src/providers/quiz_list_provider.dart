import 'package:domain_entities/domain_entities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiz_repository/quiz_repository.dart';

part 'quiz_list_state.dart';

class QuizListProvider with ChangeNotifier {
  QuizListState _filterState = QuizListState.initial();
  QuizListState _state = QuizListState.initial();

  QuizListProvider({required this.repository});
  final QuizRepository repository;

  QuizListState get filterState => _filterState;
  QuizListState get state => _state;

  Future<void> fetchAndSetQuizes() async {
    _state = _state.copyWith(status: QuizListStatus.loading);
    notifyListeners();

    await Future.delayed(Duration(seconds: 1));

    final repositoryQuizzes = await repository.getAllQuizzes();

    _state = _state.copyWith(
        status: QuizListStatus.loaded,
        quizzes: repositoryQuizzes,
        filtered: repositoryQuizzes);
    notifyListeners();
  }

  Quiz findQuizById(String id) {
    return _state.quizzes.firstWhere((quiz) => quiz.id == id);
  }

  void filterQuizzes(String value) {
    List<Quiz> quizzes = <Quiz>[];

    if (value.isNotEmpty) {
      for (Quiz quiz in _state.quizzes) {
        if (value[0] == "#") {
          for (String tag in quiz.tags) {
            if (tag.toLowerCase().contains(value.substring(1).toLowerCase())) {
              quizzes.add(quiz);
              break;
            }
          }
        } else {
          if (quiz.title.toLowerCase().contains(value.toLowerCase())) {
            quizzes.add(quiz);
          }
        }
      }
    } else {
      quizzes = _state.quizzes;
    }

    _state = _state.copyWith(filtered: quizzes);
    notifyListeners();
  }
}
