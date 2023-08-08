import 'dart:io';

import 'package:firebase_app/models/post_model.dart';
import 'package:firebase_app/models/user_model.dart';
import 'package:firebase_app/services/auth_service.dart';
import 'package:firebase_app/services/post_service.dart';
import 'package:firebase_app/services/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeViewModel {
  TextEditingController titleController = TextEditingController();
  bool isLoading = false;
  final PostService _postService = PostService();
  late final AuthService _authService;
  late final UserService _userService;
  final List<PostModel> _posts = [];
  final List<String> getImageUrl = [];
  List<File> selectedImages = [];
  String selectedPostId = "";
  List<PostModel> get posts => _posts;
  String userId = "";
  Future<void> init() async {
    _postService.init();
    _authService = AuthService();
    _userService = UserService();
    await getAllPost();
  }

  Future<UserModel> getUserById(String id) async {
    var model = await _userService.getById(id);
    userId = model.id!;
    return model;
  }

  Future<void> putImage() async {
    getImageUrl.clear();
    List<String> s = await _postService.putImage(
        _authService.currentUser!.uid, selectedImages);
    getImageUrl.addAll(s);
  }

  Future<void> submit() async {
    await createPost();
    await putImage();
    await updatePost();
  }

  Future<void> updatePost() async {
    PostModel postModel = PostModel(
      userId: _authService.currentUser!.uid,
      title: titleController.text.trim(),
      createdAt: DateTime.now(),
      postImageUrl: getImageUrl,
      id: userId,
    );
    await _postService.update(postModel);
  }

  Future<void> createPost() async {
    PostModel postModel = PostModel(
        userId: _authService.currentUser!.uid,
        title: titleController.text.trim(),
        createdAt: DateTime.now(),
        postImageUrl: [],
        id: "");
    String id = await _postService.create(postModel);
    userId = id;
  }

  Future<void> deletePost(String postId) async {
    try {
      await _postService.delete(postId);
      await getAllPost();
    } catch (e) {
      if (kDebugMode) {
        print("Error deleting post: $e");
      }
    }
  }

  Future<void> getAllPost() async {
    _posts.clear();
    var list = await _postService.getAll();
    _posts.addAll(list);
  }
}
