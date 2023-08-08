import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/models/post_model.dart';
import 'package:firebase_app/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class PostService {
  late CollectionReference<Map<String, dynamic>> _firestore;
  late Reference _storage;

  void init() {
    _firestore = FirebaseFirestore.instance.collection('posts');
    _storage = FirebaseStorage.instance.ref('posts');
  }

  Future<String> create(PostModel model) async {
    var id = _firestore.doc().id;
    model.id = id;
    await _firestore.doc(id).set(model.toJson());
    return id;
  }

  Future<void> update(PostModel model) async {
    await _firestore.doc(model.id).set(model.toJson());
  }

  Future<void> delete(String id) async {
    try {
      await _firestore.doc(id).delete();
      var listResult = await _storage.child(id).listAll();
      for (var ref in listResult.items) {
        await ref.delete();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception(e);
    }
  }

  Future<List<PostModel>> getAll() async {
    try {
      var querySnapshot =
          await _firestore.orderBy('createdAt', descending: true).get();
      List<PostModel> list =
          querySnapshot.docs.map((e) => PostModel.fromJson(e.data())).toList();
      if (kDebugMode) {
        print(list);
      }
      return list;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception(e);
    }
  }

  Future<List<PostModel>> getAllByUserId(String userId) async {
    try {
      var querySnapshot = await _firestore
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();
      List<PostModel> list =
          querySnapshot.docs.map((e) => PostModel.fromJson(e.data())).toList();
      if (kDebugMode) {
        print(list);
      }
      return list;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw Exception(e);
    }
  }

  Future<List<PostModel>?> getAllByIds(List<String> ids) async {
    try {
      if (ids.isEmpty) {
        return null;
      }
      var querySnapshot = await _firestore
          .where('id', whereIn: ids)
          .orderBy('createdAt', descending: true)
          .get();
      List<PostModel> list =
          querySnapshot.docs.map((e) => PostModel.fromJson(e.data())).toList();
      if (kDebugMode) {
        print(list);
      }
      if (list.isEmpty) {
        return [];
      }
      return list;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }

  Future<UserModel> getById(String id) async {
    var querySnapshot = await _firestore.where('id', isEqualTo: id).get();
    return UserModel.fromJson(querySnapshot.docs.first.data());
  }

  Future<List<PostModel>> getByUserId(String userId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
        .where('userId', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .get();
    var list =
        querySnapshot.docs.map((e) => PostModel.fromJson(e.data())).toList();
    return list;
  }

  Future<List<String>> putImage(String id, List<File> files) async {
    List<String> urls = [];
    for (var file in files) {
      var nextInt = Random.secure().nextInt(99999);
      var ref = _storage.child(id).child(nextInt.toString());
      var metadata = SettableMetadata(contentType: 'image/jpeg');
      await ref.putFile(file, metadata);
      var s = await ref.getDownloadURL();
      urls.add(s);
    }
    return urls;
  }
}
