class ResponseLocalModel {
  const ResponseLocalModel({required this.text, required this.correct});

  factory ResponseLocalModel.fromJson(Map<String, dynamic> json) {
    return ResponseLocalModel(
      text: json['text'],
      correct: json['correct'] ?? false,
    );
  }

  final String text;
  final bool correct;
}
