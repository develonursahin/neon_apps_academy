import 'dart:io';

import 'package:firebase_app/models/like_model.dart';
import 'package:firebase_app/models/post_model.dart';
import 'package:firebase_app/models/user_model.dart';
import 'package:firebase_app/services/auth_service.dart';
import 'package:firebase_app/services/like_service.dart';
import 'package:firebase_app/services/post_service.dart';
import 'package:firebase_app/services/user_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel {
  TextEditingController titleController = TextEditingController();
  bool isLoading = false;
  final PostService _postService = PostService();
  final AuthService authService = AuthService();
  late UserService _userService;
  late LikeService _likeService;
  late Reference _storage;
  final List<PostModel> _posts = [];
  final List<PostModel> _likeposts = [];
  final List<String> _likes = [];
  String getImageUrl = "";
  List<PostModel> get posts => _posts;
  List<PostModel> get likeposts => _likeposts;
  List<String> get likes => _likes;
  String userId = "";
  late UserModel userModel;
  File? selectedImages;
  ProfileViewModel() {
    init();
  }

  Future<void> init() async {
    _postService.init();
    _userService = UserService();
    _likeService = LikeService();
    userModel = UserModel(
      id: "id",
      name: "name",
      userName: "userName",
      surname: "surname",
      email: "email",
    );
    await getAllPost();
    await getUserById();
    await getLikesByUserId();
    await getPostByIds();

    _storage = FirebaseStorage.instance.ref();
  }

  Future<void> getLikesByUserId() async {
    _likes.clear();
    LikeModel? likeModel =
        await _likeService.getByUserId(authService.currentUser!.uid);
    _likes.addAll(likeModel!.postIds!);
  }

  Future<void> getPostByIds() async {
    _likeposts.clear();
    var list = await _postService.getAllByIds(_likes);
    if (list == null) {
      return;
    }
    _likeposts.addAll(list);
  }

  Future<UserModel> getUserById() async {
    userModel = await _userService.getById(authService.currentUser!.uid);
    return userModel;
  }

  Future<void> putImage() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImages = File(pickedFile.path);
    }
  }

  Future<void> updateUser() async {
    if (selectedImages != null) {
      String downloadUrl = await _uploadImage(selectedImages!);
      userModel.userImageUrl = downloadUrl;
    }
    await _userService.update(userModel);
  }

  Future<String> _uploadImage(File file) async {
    final Reference storageRef = _storage.child(authService.currentUser!.uid);
    final TaskSnapshot uploadTask = await storageRef.putFile(file);
    String downloadUrl = await uploadTask.ref.getDownloadURL();
    if (kDebugMode) {
      print('Image uploaded. Download URL: $downloadUrl');
    }
    return downloadUrl;
  }

  Future<void> signOut() async {
    await authService.signOut();
  }

  Future<void> getAllPost() async {
    _posts.clear();
    var list = await _postService.getAllByUserId(authService.currentUser!.uid);
    _posts.addAll(list);
  }
}
