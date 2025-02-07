import 'package:domain_entities/domain_entities.dart';
import 'package:quiz_repository/quiz_repository.dart';

extension QuizLocalModelToDomain on QuizLocalModel {
  Quiz toDomainEntity(List<Question> questions) {
    return Quiz(
      creator: creator,
      title: title,
      description: description,
      tags: tags,
      questions: questions,
    );
  }
}
