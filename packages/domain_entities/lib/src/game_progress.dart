import 'package:equatable/equatable.dart';

class GameProgress extends Equatable {
  const GameProgress({
    required this.id,
    required this.index,
    required this.point,
    required this.seed,
  });

  final String id;
  final int index;
  final int point;
  final int seed;

  GameProgress copyWith({
    String? id,
    int? index,
    int? point,
    int? seed,
  }) {
    return GameProgress(
      id: id ?? this.id,
      index: index ?? this.index,
      point: point ?? this.point,
      seed: seed ?? this.seed,
    );
  }

  @override
  List<Object?> get props => [id, index, point, seed];

  @override
  bool? get stringify => true;
}
