import 'package:equatable/equatable.dart';

class Question extends Equatable {
  const Question({
    required this.title,
    required this.answers,
    required this.rightAnswer,
  });

  final String title;
  final List<String> answers;
  final int rightAnswer;

  @override
  List<Object?> get props => [
        title,
        answers,
        rightAnswer,
      ];

  @override
  bool? get stringify => true;
}
