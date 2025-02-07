part of 'quiz_list_provider.dart';

enum QuizListStatus {
  initial,
  loading,
  loaded,
}

class QuizListState extends Equatable {
  const QuizListState({
    required this.quizes,
    required this.state,
  });

  final QuizListStatus state;
  final List<Quiz> quizes;

  factory QuizListState.initial() {
    return QuizListState(
        quizes: List<Quiz>.empty(), state: QuizListStatus.initial);
  }

  @override
  List<Object?> get props => [state, quizes];

  QuizListState copyWith({
    QuizListStatus? state,
    List<Quiz>? quizes,
  }) {
    return QuizListState(
      quizes: quizes ?? this.quizes,
      state: state ?? this.state,
    );
  }
}
