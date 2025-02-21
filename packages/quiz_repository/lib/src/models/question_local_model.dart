class QuestionLocalModel {
  const QuestionLocalModel({
    required this.title,
  });

  factory QuestionLocalModel.fromJson(Map<String, dynamic> json) {
    return QuestionLocalModel(
      title: json['title'],
    );
  }

  final String title;
}
