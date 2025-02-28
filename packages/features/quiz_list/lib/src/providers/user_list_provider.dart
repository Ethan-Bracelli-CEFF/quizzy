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

  void updateUser(User user) async {
    try {
      final index = _state.users.indexWhere((user) => user.id == user.id);
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

  void addAchievement({required Achievement achievement, User? user}) async {
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
      {required Achievement achievement,
      User? user,
      required String quizId}) async {
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

  void addLike({User? user, required String like}) async {
    final User finalUser = user ?? userState.user;
    try {
      await repository.addLike(finalUser, like, finalUser.likes.length);
      _state.users.firstWhere((u) => u.id == finalUser.id).likes.add(like);
      //TODO : refilter & delete this notify
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void deleteLike({User? user, required String like}) async {
    final User finalUser = user ?? userState.user;
    try {
      await repository.deleteLike(
          finalUser, finalUser.interests.indexWhere((l) => l == like));
      _state.users.firstWhere((u) => u.id == finalUser.id).likes.remove(like);
      //TODO : refilter & delete this notify
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void addInterest({User? user, required String interest}) async {
    final User finalUser = user ?? userState.user;
    try {
      await repository.addInterest(
          finalUser, interest, finalUser.interests.length);
      _state.users
          .firstWhere((u) => u.id == finalUser.id)
          .interests
          .add(interest);
      //TODO : refilter & delete this notify
      _userState = _userState.copyWith(user: _state.users[0]);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void deleteInterest({User? user, required String interest}) async {
    final User finalUser = user ?? userState.user;
    final interests =
        _state.users.firstWhere((u) => u.id == finalUser.id).interests;
    try {
      interests.remove(interest);
      await repository.deleteInterest(finalUser, interests);
      _state.users
          .firstWhere((u) => u.id == finalUser.id)
          .interests
          .remove(interest);
      //TODO : refilter & delete this notify
      _userState = _userState.copyWith(user: _state.users[0]);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
