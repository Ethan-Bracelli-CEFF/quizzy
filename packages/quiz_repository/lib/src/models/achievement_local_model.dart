class AchievementLocalModel {
  const AchievementLocalModel(this.id, this.star, this.hightscore);

  factory AchievementLocalModel.fromJson(Map<String, dynamic> json) {
    return AchievementLocalModel(json['id'], json['star'], json['highscore']);
  }

  final String id;
  //TODO : int / double
  final double star;
  final int hightscore;
}
