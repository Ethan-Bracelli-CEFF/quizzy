class QuizRemoteModel {
  const QuizRemoteModel({
    required this.creator,
    required this.title,
    required this.description,
    required this.tags,
  });

  factory QuizRemoteModel.fromJson(Map<String, dynamic> json) {
    final tags = <String>[];
    json['tags'].forEach((tag) {
      tags.add(tag.toString());
    });
    return QuizRemoteModel(
      creator: json['creator'],
      title: json['title'],
      description: json['description'],
      tags: tags,
    );
  }

  final String creator;
  final String title;
  final String description;
  final List<String> tags;

  Map<String, dynamic> toJson() => {
        "creator": "",
      };
}
