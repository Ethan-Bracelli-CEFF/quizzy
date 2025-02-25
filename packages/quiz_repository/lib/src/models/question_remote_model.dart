class QuestionRemoteModel {
  const QuestionRemoteModel({
    required this.title,
  });

  factory QuestionRemoteModel.fromJson(Map<String, dynamic> json) {
    return QuestionRemoteModel(
      title: json['title'],
    );
  }

  final String title;
}
