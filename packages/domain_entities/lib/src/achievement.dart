// ignore_for_file: public_member_api_docs, sort_constructors_first
class Achievement {
  const Achievement({
    required this.id,
    required this.star,
    required this.hightscore,
  });

  final String id;
  final double star;
  final int hightscore;

  Achievement copyWith({
    String? id,
    double? star,
    int? hightscore,
  }) {
    return Achievement(
      id: id ?? this.id,
      star: star ?? this.star,
      hightscore: hightscore ?? this.hightscore,
    );
  }
}
