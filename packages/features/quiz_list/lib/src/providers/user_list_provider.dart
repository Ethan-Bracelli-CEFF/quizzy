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
    try {
      _state = _state.copyWith(status: UserListStatus.loading);
      notifyListeners();

      final repositoryUsers = await repository.getAllUsers();
      _state = _state.copyWith(
        status: UserListStatus.loaded,
        users: repositoryUsers,
      );
      _userState =
          _userState.copyWith(user: _state.users[0], status: UserStatus.loaded);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
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

  void updateUser(User? user) async {
    final User finalUser = user ?? userState.user;
    try {
      final index = _state.users.indexWhere((user) => user.id == finalUser.id);
      if (index != -1) {
        await repository.updateUser(finalUser);
        _state.users[index] = finalUser;
      }
      //TODO : refilter & delete this notify
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void deleteUser(User? user) async {
    final User finalUser = user ?? userState.user;
    try {
      await repository.deleteUser(finalUser);
      _state.users.remove(user);
      //TODO : refilter & delete this notify
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void addAchievement(Achievement achievement, User? user) async {
    final User finalUser = user ?? userState.user;
    try {
      await repository.addAchievement(
          achievement, finalUser.id!, finalUser.achievement.length);
      _state.users
          .firstWhere((u) => u.id == finalUser.id)
          .achievement
          .add(achievement);
      //TODO : refilter & delete this notify
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void updateAchievement(
      Achievement achievement, User? user, String quizId) async {
    final User finalUser = user ?? userState.user;
    final int index = finalUser.achievement.indexWhere((a) => a.id == quizId);
    try {
      await repository.addAchievement(achievement, finalUser.id!, index);
      _state.users.firstWhere((u) => u.id == finalUser.id).achievement[index] =
          achievement;
      //TODO : refilter & delete this notify
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void addLike(User? user, String like) async {
    final User finalUser = user ?? userState.user;
    final int index = finalUser.likes.length;
    try {
      await repository.addLike(finalUser, like, index);
      _state.users.firstWhere((u) => u.id == finalUser.id).likes.add(like);
      //TODO : refilter & delete this notify
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void updateLike(User? user, String oldLike, String newLike) async {
    final User finalUser = user ?? userState.user;
    final int index = finalUser.interests.indexWhere((i) => i == oldLike);
    try {
      await repository.addLike(finalUser, newLike, index);
      _state.users.firstWhere((u) => u.id == finalUser.id).likes[index] =
          newLike;
      //TODO : refilter & delete this notify
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
