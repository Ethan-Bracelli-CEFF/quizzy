import 'package:domain_entities/domain_entities.dart';
import 'package:quiz_repository/quiz_repository.dart';

extension GameProgressRmoteMapper on GameProgressRemoteModel {
  GameProgress toDomainEntity() {
    return GameProgress(id: id, index: index, point: point, seed: seed);
  }
}
