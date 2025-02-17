part of 'quiz_list_provider.dart';

enum QuizListStatus {
  initial,
  loading,
  loaded,
}

class QuizListState extends Equatable {
  const QuizListState({
    required this.quizzes,
    required this.status,
  });

  final QuizListStatus status;
  final List<Quiz> quizzes;

  factory QuizListState.initial() {
    return QuizListState(
        quizzes: List<Quiz>.empty(), status: QuizListStatus.initial);
  }

  @override
  List<Object?> get props => [status, quizzes];

  QuizListState copyWith({
    QuizListStatus? status,
    List<Quiz>? quizzes,
  }) {
    return QuizListState(
      quizzes: quizzes ?? this.quizzes,
      status: status ?? this.status,
    );
  }
}
