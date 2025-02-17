class QuestionLocalModel {
  const QuestionLocalModel({
    required this.title,
    required this.answers,
    required this.rightAnswer,
  });

  factory QuestionLocalModel.fromJson(Map<String, dynamic> json) {
    final answers = <String>[];
    json['responses'].forEach((answer) {
      answers.add(answer.toString());
    });
    return QuestionLocalModel(
      title: json['title'],
      answers: answers,
      rightAnswer: json['correct_answer'],
    );
  }

  final String title;
  final List<String> answers;
  final int rightAnswer;
}
