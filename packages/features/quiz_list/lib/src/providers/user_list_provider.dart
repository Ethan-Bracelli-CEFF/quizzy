import 'package:domain_entities/domain_entities.dart';
import 'package:flutter/material.dart';
import 'package:quiz_list/quiz_list.dart';
import 'package:quiz_repository/quiz_repository.dart';

class UserListProvider with ChangeNotifier {
  UserListState _state = UserListState.initial();
  UserState _userState = UserState.initial();

  UserListProvider({required this.repository});
  final QuizRepository repository;

  UserListState get state => _state;
  UserState get userState => _userState;

  Future<void> fetchAndSetUsers() async {
    _state = _state.copyWith(status: UserListStatus.loading);
    notifyListeners();

    final repositoryUsers = await repository.getAllUsers();
    _state = _state.copyWith(
      status: UserListStatus.loaded,
      users: repositoryUsers,
    );
    _userState =
        _userState.copyWith(user: _state.users[2], status: UserStatus.loaded);
    notifyListeners();
  }

  User findUserById(String id) {
    return _state.users.firstWhere((user) => user.id == id);
  }

  int findUserIndexById(String id) {
    return _state.users.indexWhere((user) => user.id == id);
  }

  void addUser(User user) async {
    try {
      User newUser = await repository.addUser(user);
      _state.users.add(newUser);
      //TODO : refilter & delete this notify
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void updateUser(User user) async {
    try {
      final index = findUserIndexById(user.id ?? '');
      if (index != -1) {
        await repository.updateUser(user);
        _state.users[index] = user;
      }
      //TODO : refilter & delete this notify
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void deleteUser(User user) async {
    try {
      await repository.deleteUser(user);
      _state.users.remove(user);
      //TODO : refilter & delete this notify
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
