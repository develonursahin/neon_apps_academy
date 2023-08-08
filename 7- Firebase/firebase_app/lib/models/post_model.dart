import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? userId;
  String? id;
  String? title;
  DateTime? createdAt;
  List<String>? postImageUrl;
  PostModel({
    required this.userId,
    required this.title,
    required this.createdAt,
    required this.postImageUrl,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'createdAt': Timestamp.fromDate(createdAt!),
      'postImageUrl': postImageUrl,
    };
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      userId: json['userId'] != null ? json['userId'] as String : null,
      id: json['id'] != null ? json['id'] as String : null,
      title: json['title'] != null ? json['title'] as String : null,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      postImageUrl: List.from((json['postImageUrl'] as List<dynamic>)),
    );
  }
  
}
