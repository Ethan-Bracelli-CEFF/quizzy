import 'package:domain_entities/domain_entities.dart';
import 'package:quiz_repository/quiz_repository.dart';

extension QuestionToRemoteModel on Question {
  QuestionRemoteModel toRemoteModel() {
    return QuestionRemoteModel(title: title);
  }
}
