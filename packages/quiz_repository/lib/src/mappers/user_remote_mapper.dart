import 'package:domain_entities/domain_entities.dart';
import 'package:quiz_repository/quiz_repository.dart';

extension UserRemoteMapper on UserRemoteModel {
  User toDomainEntity(String id, List<GameProgress> gameProgress,
      List<Achievement> achievement) {
    return User(
        username: username,
        id: id,
        interests: interests,
        likes: likes,
        gameProgress: gameProgress,
        achievement: achievement);
  }
}
