class UserRemoteModel {
  const UserRemoteModel(
    this.username,
    this.interests,
    this.likes,
  );

  factory UserRemoteModel.fromJson(Map<String, dynamic> json) {
    final interests = <String>[];
    final likes = <String>[];
    json['interests'].forEach((v) {
      interests.add(v.toString());
    });
    json['likes'].forEach((v) {
      likes.add(v.toString());
    });
    return UserRemoteModel(
      json['username'],
      interests,
      likes,
    );
  }

  final String username;
  final List<String> interests;
  final List<String> likes;
}
