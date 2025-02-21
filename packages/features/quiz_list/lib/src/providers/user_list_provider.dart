import 'package:flutter/cupertino.dart';
import 'package:quiz_list/quiz_list.dart';
import 'package:quiz_repository/quiz_repository.dart';

class UserListProvider with ChangeNotifier {
  UserListState _state = UserListState.initial();

  UserListProvider({required this.repository});
  final QuizRepository repository;

  UserListState get state => _state;

  Future<void> fetchAndSetUsers() async {
    _state = _state.copyWith(status: UserListStatus.loading);
    notifyListeners();

    final repositoryUsers = await repository.getAllUsers();
    _state = _state.copyWith(
      status: UserListStatus.loaded,
      users: repositoryUsers,
    );
    notifyListeners();
  }
}
