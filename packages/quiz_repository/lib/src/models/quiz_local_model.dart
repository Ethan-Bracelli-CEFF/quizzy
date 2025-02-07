class QuizLocalModel {
  const QuizLocalModel({
        required this.title,
        required this.description,
        required this.tags,
    });

  factory QuizLocalModel.fromJson(Map<String, dynamic> json) {
    return QuizLocalModel(
      title: json['title'], 
      description: json['description'], 
      tags: json['tags'],
    );
  }

  final String title;
  final String description;
  final List<String> tags;
}