class QuizLocalModel {
  const QuizLocalModel({
    required this.creator,
    required this.title,
    required this.description,
    required this.id,
    required this.tags,
  });

  factory QuizLocalModel.fromJson(Map<String, dynamic> json) {
    final tags = <String>[];
    json['tags'].forEach((tag) {
      tags.add(tag.toString());
    });
    return QuizLocalModel(
      creator: json['creator'],
      title: json['title'],
      description: json['description'],
      id: json['id'],
      tags: tags,
    );
  }

  final String creator;
  final String title;
  final String description;
  final String id;
  final List<String> tags;
}
