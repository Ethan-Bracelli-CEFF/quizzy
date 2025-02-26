import 'package:domain_entities/domain_entities.dart';
import 'package:equatable/equatable.dart';

class Quiz extends Equatable {
  const Quiz({
    required this.creator,
    required this.title,
    required this.description,
    required this.category,
    required this.id,
    required this.tags,
    required this.questions,
  });

  final String creator;
  final String title;
  final String description;
  final String category;
  final String? id;
  final List<String> tags;
  final List<Question> questions;

  Quiz copyWith({
    final String? creator,
    final String? title,
    final String? description,
    final String? category,
    final String? id,
    final List<String>? tags,
    final List<Question>? questions,
  }) {
    return Quiz(
      creator: creator ?? this.creator,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      id: id ?? this.id,
      tags: tags ?? this.tags,
      questions: questions ?? this.questions,
    );
  }

  @override
  List<Object?> get props => [
        creator,
        title,
        description,
        category,
        id,
        tags,
        questions,
      ];

  @override
  bool? get stringify => true;
}
