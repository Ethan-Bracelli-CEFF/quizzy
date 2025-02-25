import 'package:domain_entities/domain_entities.dart';
import 'package:quiz_repository/quiz_repository.dart';

extension AchievementLocalMapper on AchievementLocalModel {
  Achievement toDomainEntity() {
    return Achievement(id: id, star: star, hightscore: hightscore);
  }
}
