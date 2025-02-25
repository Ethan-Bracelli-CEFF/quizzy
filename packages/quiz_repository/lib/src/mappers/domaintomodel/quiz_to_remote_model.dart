import 'package:domain_entities/domain_entities.dart';
import 'package:quiz_repository/quiz_repository.dart';

extension QuizToModelRemote on Quiz {
  QuizRemoteModel toRemoteModel() {
    return QuizRemoteModel(
      creator: creator,
      title: title,
      description: description,
      category: category,
      tags: tags,
    );
  }
}
