import 'package:domain_entities/domain_entities.dart';
import 'package:quiz_repository/quiz_repository.dart';

extension AchievementToModelRemote on Achievement {
  AchievementRemoteModel toRemoteModel() {
    return AchievementRemoteModel(id, star, hightscore);
  }
}
