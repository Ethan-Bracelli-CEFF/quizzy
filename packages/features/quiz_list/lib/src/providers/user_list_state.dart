import 'package:domain_entities/domain_entities.dart';

enum UserListStatus {
  initial,
  loading,
  loaded,
}

class UserListState {
  const UserListState({required this.status, required this.users});

  factory UserListState.initial() {
    return UserListState(
      status: UserListStatus.initial,
      users: List<User>.empty(),
    );
  }

  final UserListStatus status;
  final List<User> users;

  UserListState copyWith({
    final UserListStatus? status,
    final List<User>? users,
  }) {
    return UserListState(
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }
}
