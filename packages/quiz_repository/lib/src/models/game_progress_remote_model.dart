class GameProgressRemoteModel {
  const GameProgressRemoteModel(this.id, this.index, this.point, this.seed);

  factory GameProgressRemoteModel.fromJson(Map<String, dynamic> json) {
    return GameProgressRemoteModel(
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
