// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:domain_entities/domain_entities.dart';

class User {
  const User({
    required this.username,
    required this.id,
    required this.interests,
    required this.likes,
    required this.gameProgress,
    required this.achievement,
  });

  final String username;
  final String id;
  final List<String> interests;
  final List<String> likes;
  final List<GameProgress> gameProgress;
  final List<Achievement> achievement;

  User copyWith({
    String? username,
    String? id,
    List<String>? interests,
    List<String>? likes,
    List<GameProgress>? gameProgress,
    List<Achievement>? achievement,
  }) {
    return User(
      username: username ?? this.username,
      id: id ?? this.id,
      interests: interests ?? this.interests,
      likes: likes ?? this.likes,
      gameProgress: gameProgress ?? this.gameProgress,
      achievement: achievement ?? this.achievement,
    );
  }
}
