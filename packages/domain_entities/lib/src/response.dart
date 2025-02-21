class Response {
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
}
