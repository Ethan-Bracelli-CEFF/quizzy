class GameProgressLocalModel {
  const GameProgressLocalModel(this.id, this.index, this.point, this.seed);

  factory GameProgressLocalModel.fromJson(Map<String, dynamic> json) {
    return GameProgressLocalModel(
      json['id'],
      json['index'],
      json['point'],
      json['seed'],
    );
  }

  final String id;
  final int index;
  final int point;
  final int seed;
}
