part of 'quiz_list_provider.dart';

enum QuizListStatus {
  initial,
  loading,
  loaded,
}

class QuizListState extends Equatable {
  const QuizListState({
    required this.quizes,
    required this.status,
  });

  final QuizListStatus status;
  final List<Quiz> quizes;

  factory QuizListState.initial() {
    return QuizListState(
        quizes: List<Quiz>.empty(), status: QuizListStatus.initial);
  }

  @override
  List<Object?> get props => [status, quizes];

  QuizListState copyWith({
    QuizListStatus? state,
    List<Quiz>? quizes,
  }) {
    return QuizListState(
      quizes: quizes ?? this.quizes,
      status: state ?? status,
    );
  }
}
