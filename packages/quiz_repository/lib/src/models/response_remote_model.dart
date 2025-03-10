class ResponseRemoteModel {
  const ResponseRemoteModel({required this.text, required this.correct});

  factory ResponseRemoteModel.fromJson(Map<String, dynamic> json) {
    return ResponseRemoteModel(
      text: json['text'],
      correct: json['correct'] ?? false,
    );
  }

  final String text;
  final bool correct;

  Map<String, dynamic> toJson() {
    return correct ? {"text": text, "correct": correct} : {"text": text};
  }
}
