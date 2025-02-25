import 'package:domain_entities/domain_entities.dart';

enum UserStatus {
  initial,
  loading,
  loaded,
}

class UserState {
  const UserState({required this.status, required this.user});

  factory UserState.initial() {
    return UserState(
      status: UserStatus.initial,
      user: User(
          username: '',
          id: '',
          interests: [],
          likes: [],
          gameProgress: [],
          achievement: []),
    );
  }

  final UserStatus status;
  final User user;

  UserState copyWith({
    final UserStatus? status,
    final User? user,
  }) {
    return UserState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
