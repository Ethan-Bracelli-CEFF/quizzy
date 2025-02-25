// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Achievement extends Equatable {
  const Achievement({
    required this.id,
    required this.star,
    required this.hightscore,
  });

  final String id;
  final int star;
  final int hightscore;

  Achievement copyWith({
    String? id,
    int? star,
    int? hightscore,
  }) {
    return Achievement(
      id: id ?? this.id,
      star: star ?? this.star,
      hightscore: hightscore ?? this.hightscore,
    );
  }

  @override
  List<Object?> get props => [id, star, hightscore];

  @override
  bool? get stringify => true;
}
