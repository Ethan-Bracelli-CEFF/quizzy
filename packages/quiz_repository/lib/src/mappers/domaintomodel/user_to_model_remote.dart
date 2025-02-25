import 'package:domain_entities/domain_entities.dart';
import 'package:quiz_repository/quiz_repository.dart';

extension UserToModelRemote on User {
  UserRemoteModel toRemoteModel() {
    return UserRemoteModel(username, interests, likes);
  }
}
