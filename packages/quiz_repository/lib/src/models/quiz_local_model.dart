class QuizLocalModel {
  const QuizLocalModel({
    required this.creator,
    required this.title,
    required this.description,
    required this.tags,
  });

  factory QuizLocalModel.fromJson(Map<String, dynamic> json) {
    return QuizLocalModel(
      creator: json['creator'],
      title: json['title'],
      description: json['description'],
      tags: json['tags'],
    );
  }

  final String creator;
  final String title;
  final String description;
  final List<String> tags;
}
