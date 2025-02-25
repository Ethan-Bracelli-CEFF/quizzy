import 'package:diacritic/diacritic.dart';
import 'package:domain_entities/domain_entities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiz_repository/quiz_repository.dart';

part 'quiz_list_state.dart';

class QuizListProvider with ChangeNotifier {
  QuizListState _state = QuizListState.initial();

  QuizListProvider({required this.repository});
  final QuizRepository repository;

  QuizListState get state => _state;

  Future<void> fetchAndSetQuizes() async {
    _state = _state.copyWith(status: QuizListStatus.loading);
    notifyListeners();

    await Future.delayed(Duration(seconds: 1));

    final repositoryQuizzes = await repository.getAllQuizzes();

    _state = _state.copyWith(
        status: QuizListStatus.loaded,
        quizzes: repositoryQuizzes,
        filteredCategory: repositoryQuizzes,
        filtered: repositoryQuizzes);
    notifyListeners();
  }

  Quiz findQuizById(String id) {
    return _state.quizzes.firstWhere((quiz) => quiz.id == id);
  }

  void filterQuizzes(String value) {
    List<Quiz> quizzes = <Quiz>[];

    final cleanValue = removeDiacritics(value.toLowerCase());

    if (value.isNotEmpty) {
      for (Quiz quiz in _state.filteredCategory) {
        if (value[0] == "#") {
          for (String tag in quiz.tags) {
            final cleanTag = removeDiacritics(tag.toLowerCase());

            if (cleanTag.contains(cleanValue.substring(1))) {
              quizzes.add(quiz);
              break;
            }
          }
        } else {
          final cleanTitle = removeDiacritics(quiz.title.toLowerCase());

          if (cleanTitle.contains(cleanValue)) {
            quizzes.add(quiz);
          }
        }
      }
    } else {
      quizzes = _state.filteredCategory;
    }

    _state = _state.copyWith(filtered: quizzes);
    notifyListeners();
  }

  void filterCategories(String value) async {
    final cleanValue = removeDiacritics(value.toLowerCase());
    List<Quiz> quizzes = <Quiz>[];

    if (value != "Tous") {
      for (Quiz quiz in _state.quizzes) {
        if (removeDiacritics(quiz.category.toLowerCase()) == cleanValue) {
          quizzes.add(quiz);
        }
      }
    } else {
      quizzes = _state.quizzes;
    }

    _state = _state.copyWith(filtered: quizzes);
    _state = _state.copyWith(filteredCategory: quizzes);
    notifyListeners();
  }

  void addQuiz(Quiz quiz) async {
    Quiz newQuiz = await repository.addQuiz(quiz);
    _state.quizzes.add(newQuiz);
    //TODO : refilter & delete this notify
    notifyListeners();
  }
}
