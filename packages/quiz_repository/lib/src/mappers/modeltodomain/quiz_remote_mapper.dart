import 'package:domain_entities/domain_entities.dart';
import 'package:quiz_repository/quiz_repository.dart';

extension QuizRemoteMapper on QuizRemoteModel {
  Quiz toDomainEntity(String id, List<Question> questions) {
    return Quiz(
        creator: creator,
        title: title,
        description: description,
        id: id,
        tags: tags,
        questions: questions);
  }
}
