import 'package:domain_entities/domain_entities.dart';
import 'package:quiz_repository/quiz_repository.dart';

extension GameProgressToModelRemote on GameProgress {
  GameProgressRemoteModel toRemoteModel() {
    return GameProgressRemoteModel(id, index, point, seed);
  }
}
