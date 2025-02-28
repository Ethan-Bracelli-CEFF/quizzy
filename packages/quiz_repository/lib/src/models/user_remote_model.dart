class UserRemoteModel {
  const UserRemoteModel(
    this.username,
    this.interests,
    this.likes,
  );

  factory UserRemoteModel.fromJson(Map<String, dynamic> json) {
    final interests = <String>[];
    final likes = <String>[];
    if (json['interests'] != null) {
      json['interests'].forEach((v) {
        interests.add(v.toString());
      });
    }
    if (json['likes'] != null) {
      json['likes'].forEach((v) {
        likes.add(v.toString());
      });
    }
    return UserRemoteModel(
      json['username'],
      interests,
      likes,
    );
  }

  final String username;
  final List<String> interests;
  final List<String> likes;

  Map<String, dynamic> toJson(List<Map<String, dynamic>> achievement,
          List<Map<String, dynamic>> gameProgress) =>
      {
        "username": username,
        "interests": interests,
        "likes": likes,
        "achievements": achievement,
        "in_progress": gameProgress
      };
}
