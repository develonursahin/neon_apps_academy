class LikeModel {
  final String id;
  final String userId;
  final List<String>? postIds;

  LikeModel({
    required this.id,
    required this.userId,
    this.postIds,
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      id: json['id'],
      userId: json['userId'],
      postIds: List<String>.from(json['postIds'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'postIds': postIds,
    };
  }
}
