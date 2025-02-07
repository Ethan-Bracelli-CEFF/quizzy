import 'package:domain_entities/domain_entities.dart';

class Quiz {
  const Quiz({
    required this.creator,
    required this.title,
    required this.description,
    required this.tags,
    required this.questions,
  });

  final String creator;
  final String title;
  final String description;
  final List<String> tags;
  final List<Question> questions;

  Quiz copyWith({
    final String? creator,
    final String? title,
    final String? description,
    final List<String>? tags,
    final List<Question>? questions,
  }) {
    return Quiz(
      creator: creator ?? this.creator,
      title: title ?? this.title,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      questions: questions ?? this.questions,
    );
  }
}
