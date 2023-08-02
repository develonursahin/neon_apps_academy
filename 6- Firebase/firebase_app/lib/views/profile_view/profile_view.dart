import 'dart:io';
import 'package:firebase_app/models/post_model.dart';
import 'package:firebase_app/views/home_view/home_viewmodel.dart';
import 'package:firebase_app/views/profile_view/profile_viewmodel.dart';
import 'package:firebase_app/views/splash_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Post {
  String imageUrl;
  String description;
  int likeCount;

  Post(this.imageUrl, this.description, this.likeCount);
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileViewModel _viewModel = ProfileViewModel();
  final HomeViewModel homeViewModel = HomeViewModel();
  TextEditingController likeController = TextEditingController();

  bool isLoading = false;

  String? imagePath;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setState(() {
      isLoading = true;
    });
    await _viewModel.init();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () async {
                await _viewModel.signOut();
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SplashView(),
                    ));
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      InkWell(
                        onLongPress: () {
                          showChangeProfileImageDialog(context);
                        },
                        child: _viewModel.userModel.userImageUrl == null
                            ? const CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    "https://www.tech101.in/wp-content/uploads/2018/07/blank-profile-picture.png"),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    _viewModel.userModel.userImageUrl!),
                              ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "@${_viewModel.userModel.userName!}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "${_viewModel.userModel.name!} ${_viewModel.userModel.surname!}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                DefaultTabController(
                  length: 2,
                  child: Expanded(
                    child: Column(
                      children: [
                        const TabBar(
                          tabs: [
                            Tab(text: "My Posts"),
                            Tab(text: "Liked Posts"),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              FutureBuilder(builder: (context, snapshot) {
                                return _buildMyPostsGridView();
                              }),
                              FutureBuilder(builder: (context, snapshot) {
                                return _buildLikedPostsGridView();
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildMyPostsGridView() {
    if (_viewModel.posts.isEmpty) {
      return const Center(child: Text('No posts found.'));
    }
    return isLoading
        ? const CircularProgressIndicator()
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.75,
            ),
            itemCount: _viewModel.posts.length,
            itemBuilder: (context, index) {
              return _buildPostCard(_viewModel.posts[index]);
            },
          );
  }

  Widget _buildLikedPostsGridView() {
    if (_viewModel.likes.isEmpty && _viewModel.likeposts.isEmpty) {
      return const Center(child: Text('No liked posts found.'));
    }
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.75,
      ),
      itemCount: _viewModel.likeposts.length,
      itemBuilder: (context, index) {
        return _buildPostCard(_viewModel.likeposts[index]);
      },
    );
  }

  Widget _buildPostCard(PostModel post) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                post.postImageUrl![0],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            post.title!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }

  Future<void> showChangeProfileImageDialog(BuildContext context) async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Change Profile Image"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.file(File(pickedFile.path)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    String imageUrl = await _uploadImage(File(pickedFile.path));
                    _viewModel.userModel.userImageUrl = imageUrl;
                    if (kDebugMode) {
                      print(
                          'Updated userImageUrl: ${_viewModel.userModel.userImageUrl}');
                    }
                    await _viewModel.updateUser();

                    setState(() {
                      isLoading = false;
                    });

                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                    await init();
                  },
                  child: const Text("Upload Image"),
                ),
              ],
            ),
          );
        },
      );
    }
  }

  Future<String> _uploadImage(File file) async {
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child(_viewModel.authService.currentUser!.uid);
    final TaskSnapshot uploadTask = await storageRef.putFile(file);
    String downloadUrl = await uploadTask.ref.getDownloadURL();
    if (kDebugMode) {
      print('Image uploaded. Download URL: $downloadUrl');
    }
    return downloadUrl;
  }
}
