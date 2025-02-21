class UserLocalModel {
  const UserLocalModel(
    this.username,
    this.id,
    this.interests,
    this.likes,
  );

  factory UserLocalModel.fromJson(Map<String, dynamic> json) {
    final interests = <String>[];
    final likes = <String>[];
    json['interests'].forEach((v) {
      interests.add(v.toString());
    });
    json['likes'].forEach((v) {
      likes.add(v.toString());
    });
    return UserLocalModel(
      json['username'],
      json['id'],
      interests,
      likes,
    );
  }

  final String username;
  final String id;
  final List<String> interests;
  final List<String> likes;
}
