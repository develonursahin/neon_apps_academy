import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? id;
  String? userName;
  String? postId;
  String? commentText;
  DateTime? createdAt;
  CommentModel({
    required this.userName,
    required this.postId,
    required this.id,
    required this.commentText,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'userId': userName,
      'postId': postId,
      'commentText': commentText,
      'createdAt': Timestamp.fromDate(createdAt!),
    };
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] != null ? json['id'] as String : null,
      userName: json['userId'] != null ? json['userId'] as String : null,
      postId: json['postId'] != null ? json['postId'] as String : null,
      commentText:
          json['commentText'] != null ? json['commentText'] as String : null,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }
}
