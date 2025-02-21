import 'package:equatable/equatable.dart';

class Response extends Equatable {
  const Response({
    required this.text,
    required this.correct,
  });

  final String text;
  final bool correct;

  Response copyWith({
    final String? text,
    final bool? correct,
  }) {
    return Response(text: text ?? this.text, correct: correct ?? this.correct);
  }

  @override
  List<Object?> get props => [text, correct];

  @override
  bool? get stringify => true;
}
