import 'package:domain_entities/domain_entities.dart';
import 'package:quiz_repository/quiz_repository.dart';

extension ResponseToRemoteModel on Response {
  ResponseRemoteModel toRemoteModel() {
    return ResponseRemoteModel(text: text, correct: correct);
  }
}
