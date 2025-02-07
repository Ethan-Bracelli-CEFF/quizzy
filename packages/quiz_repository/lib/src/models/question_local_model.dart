class QuestionLocalModel {
  const QuestionLocalModel({
    required this.title,
    required this.answers,
    required this.rightAnswer,
  });

  factory QuestionLocalModel.fromJson(Map<String, dynamic> json) {
    return QuestionLocalModel(
      title: json['title'],
      answers: json['responses'],
      rightAnswer: json['correct_answer'],
    );
  }

  final String title;
  final List<String> answers;
  final int rightAnswer;
}
