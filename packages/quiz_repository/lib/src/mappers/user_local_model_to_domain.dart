import 'package:domain_entities/domain_entities.dart';
import 'package:quiz_repository/quiz_repository.dart';

extension UserLocalModelToDomain on UserLocalModel {
  User toDomainEntity(
      List<GameProgress> gameProgress, List<Achievement> achievement) {
    return User(
      username: username,
      id: id,
      interests: interests,
      likes: likes,
      gameProgress: gameProgress,
      achievement: achievement,
    );
  }
}
