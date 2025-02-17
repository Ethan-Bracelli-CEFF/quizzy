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

    _state.copyWith(status: QuizListStatus.loaded, quizzes: repositoryQuizzes);
    notifyListeners();
  }
}
