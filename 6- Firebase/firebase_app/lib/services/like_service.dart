import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/models/like_model.dart';

class LikeService {
  late final CollectionReference<Map<String, dynamic>> _firestore;
  LikeService() {
    init();
  }
  void init() {
    _firestore = FirebaseFirestore.instance.collection('likes');
  }

  Future<void> toggleLike(String postId, String userId) async {
    var likeModel = await getByUserId(userId);

    likeModel ??= LikeModel(userId: userId, postIds: [], id: '');

    if (likeModel.postIds!.contains(postId)) {
      await unlikePost(postId, userId);
    } else {
      await likePost(postId, userId);
    }
  }

  Future<LikeModel?> getByUserId(String userId) async {
    var querySnapshot =
        await _firestore.where('userId', isEqualTo: userId).get();
    if (querySnapshot.docs.isEmpty) {
      return null;
    }
    if (querySnapshot.docs.first.data()['userId'] == null) {
      return null;
    }
    return LikeModel.fromJson(querySnapshot.docs.first.data());
  }

  Future<void> likePost(String postId, String userId) async {
    var likeModel = await getByUserId(userId);

    if (likeModel == null) {
      var id = _firestore.doc().id;
      likeModel = LikeModel(userId: userId, postIds: [], id: id);
    }

    if (!likeModel.postIds!.contains(postId)) {
      likeModel.postIds!.add(postId);
    }

    await _firestore.doc(likeModel.id).set(likeModel.toJson());
  }

  Future<void> unlikePost(String postId, String userId) async {
    var likeModel = await getByUserId(userId);

    if (likeModel == null) {
      return;
    }

    if (likeModel.postIds!.contains(postId)) {
      likeModel.postIds!.remove(postId);
      await _firestore.doc(likeModel.id).set(likeModel.toJson());
    }
  }
}
