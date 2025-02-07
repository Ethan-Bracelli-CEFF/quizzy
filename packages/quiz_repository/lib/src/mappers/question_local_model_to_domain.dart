import 'package:domain_entities/domain_entities.dart';
import 'package:quiz_repository/quiz_repository.dart';

extension QuestionLocalModelToDomain on QuestionLocalModel {
  Question toDomainEntity() {
    return Question(
      title: title,
      answers: answers,
      rightAnswer: rightAnswer,
    );
  }
}
