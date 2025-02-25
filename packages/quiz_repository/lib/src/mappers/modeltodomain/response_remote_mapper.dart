import 'package:domain_entities/domain_entities.dart';
import 'package:quiz_repository/quiz_repository.dart';

extension ResponseRemoteMapper on ResponseRemoteModel {
  Response toDomainEntity() {
    return Response(text: text, correct: correct);
  }
}
