import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserService {
  late final CollectionReference<Map<String, dynamic>> _firestore;
  late final Reference _storage;

  UserService() {
    _firestore = FirebaseFirestore.instance.collection('users');
    _storage = FirebaseStorage.instance.ref('users');
  }

  Future<String> putImage(String id, File file) async {
    var nextInt = Random.secure().nextInt(99999);
    var ref = _storage.child(id).child(nextInt.toString());
    var metadata = SettableMetadata(contentType: 'image/jpeg');
    await ref.putFile(file, metadata);
    var s = await ref.getDownloadURL();
    return s;
  }

  Future<void> create(UserModel model) async {
    await _firestore.doc(model.id).set(model.toJson());
  }

  Future<UserModel> getById(String id) async {
    var querySnapshot = await _firestore.where("id", isEqualTo: id).get();
    querySnapshot.docs.first;
    return UserModel.fromJson(querySnapshot.docs.first.data());
  }

  Future<void> update(UserModel model) async {
    await _firestore.doc(model.id).update(model.toJson());
  }

  Future<bool> checkUsernameExists(String userName) async {
    var querySnapshot =
        await _firestore.where("userName", isEqualTo: userName).get();
    if (querySnapshot.docs.isEmpty) {
      return false;
    }
    return true;
  }
}
