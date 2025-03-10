import 'package:diacritic/diacritic.dart';
import 'package:domain_entities/domain_entities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiz_repository/quiz_repository.dart';

part 'quiz_list_state.dart';

class QuizListProvider with ChangeNotifier {
  QuizListState _state = QuizListState.initial();

  List constQuizzes = [];

  QuizListProvider({required this.repository});
  final QuizRepository repository;

  QuizListState get state => _state;

  Future<void> fetchAndSetQuizes() async {
    _state = _state.copyWith(status: QuizListStatus.loading);
    notifyListeners();

    final repositoryQuizzes = await repository.getAllQuizzes();

    constQuizzes = repositoryQuizzes;

    _state = _state.copyWith(
      status: QuizListStatus.loaded,
      quizzes: repositoryQuizzes,
    );
    notifyListeners();
  }

  Quiz findUnshuffledQuizById(String id) {
    return constQuizzes.firstWhere((quiz) => quiz.id == id);
  }

  Quiz findQuizById(String id) {
    return _state.quizzes.firstWhere((quiz) => quiz.id == id);
  }

  int findQuizIndexById(String id) {
    return _state.quizzes.indexWhere((quiz) => quiz.id == id);
  }

  List<Quiz> findQuizzesByAuthor(String author) {
    return _state.quizzes.where((q) => q.creator == author).toList();
  }

  List<Quiz> orderFilteredListByTag(List<String> tags, [List<Quiz>? list]) {
    final listToFilter = list ?? _state.quizzes;

    List<Quiz> quizzes = <Quiz>[];

    for (String tag in tags) {
      quizzes.addAll(listToFilter.where((q) => q.tags.contains(tag)));
    }

    final total = <Quiz>[];
    total.addAll(quizzes.toSet().toList());
    total.shuffle();
    total.addAll(listToFilter.toSet().difference(quizzes.toSet()).toList());

    return total;
  }

  List<Quiz> getFilteredListByName(String name, [List<Quiz>? list]) {
    final listToFilter = list ?? _state.quizzes;

    List<Quiz> quizzes = <Quiz>[];

    quizzes.addAll(listToFilter
        .where((q) => removeDiacritics(q.title.toLowerCase()).contains(name)));

    return quizzes;
  }

  List<Quiz> getFilteredListByCategory(String category, [List<Quiz>? list]) {
    final listToFilter = list ?? _state.quizzes;

    if (category == "Tous") {
      return listToFilter;
    }

    List<Quiz> quizzes = <Quiz>[];

    quizzes.addAll(listToFilter.where((q) => q.category == category));

    return quizzes;
  }

  List<Quiz> filterQuizzes(
      {String? name, String? categorie, List<String>? tags}) {
    List<Quiz> quizzes = <Quiz>[];
    if (categorie != null) {
      quizzes = getFilteredListByCategory(categorie);
    }

    if (name != null) {
      final cleanValue = removeDiacritics(name.toLowerCase());
      quizzes = getFilteredListByName(cleanValue, quizzes);
    }

    if (tags != null) {
      quizzes = orderFilteredListByTag(tags, quizzes);
    }

    return quizzes;
  }

  void addQuiz(Quiz quiz) async {
    try {
      Quiz newQuiz = await repository.addQuiz(quiz);
      await repository.updateQuiz(newQuiz);
      _state.quizzes.add(newQuiz);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void updateQuiz(Quiz quiz) async {
    try {
      final index = findQuizIndexById(quiz.id ?? '');
      if (index != -1) {
        await repository.updateQuiz(quiz);
        _state.quizzes[index] = quiz;
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void deleteQuiz(Quiz quiz) async {
    try {
      await repository.deleteQuiz(quiz);
      _state.quizzes.remove(quiz);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
