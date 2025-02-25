part of 'quiz_list_provider.dart';

enum QuizListStatus {
  initial,
  loading,
  loaded,
}

class QuizListState extends Equatable {
  const QuizListState({
    required this.quizzes,
    required this.filtered,
    required this.filteredCategory,
    required this.status,
  });

  final QuizListStatus status;
  final List<Quiz> filtered;
  final List<Quiz> filteredCategory;
  final List<Quiz> quizzes;

  factory QuizListState.initial() {
    return QuizListState(
      quizzes: List<Quiz>.empty(),
      filtered: List<Quiz>.empty(),
      filteredCategory: List<Quiz>.empty(),
      status: QuizListStatus.initial,
    );
  }

  @override
  List<Object?> get props => [status, quizzes];

  QuizListState copyWith({
    QuizListStatus? status,
    List<Quiz>? quizzes,
    List<Quiz>? filteredCategory,
    List<Quiz>? filtered,
  }) {
    return QuizListState(
      quizzes: quizzes ?? this.quizzes,
      filtered: filtered ?? this.filtered,
      filteredCategory: filteredCategory ?? this.filteredCategory,
      status: status ?? this.status,
    );
  }
}
