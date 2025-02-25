class AchievementRemoteModel {
  const AchievementRemoteModel(this.id, this.star, this.hightscore);

  factory AchievementRemoteModel.fromJson(Map<String, dynamic> json) {
    return AchievementRemoteModel(json['id'], json['star'], json['highscore']);
  }

  final String id;
  final int star;
  final int hightscore;

  Map<String, dynamic> toJson() =>
      {"id": id, "star": star, "highscore": hightscore};
}
