import 'dart:io';
import 'package:firebase_app/models/user_model.dart';
import 'package:firebase_app/services/remote_config_service.dart';
import 'package:firebase_app/views/home_view/home_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_app/views/home_view/home_viewmodel.dart';

class HomeViewScreen extends StatefulWidget {
  const HomeViewScreen({Key? key}) : super(key: key);

  @override
  State<HomeViewScreen> createState() => _HomeViewScreenState();
}

class _HomeViewScreenState extends State<HomeViewScreen> {
  final HomeViewModel _viewModel = HomeViewModel();
  late UserModel userModel;
  final RemoteConfigService _remoteConfigService = RemoteConfigService();
  bool isLoading = false;
  bool showAddPostDialog = false;
  String? imagePath;
  final picker = ImagePicker();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setState(() {
      isLoading = true;
    });
    _remoteConfigService.init();
    await showAddPost();
    await _viewModel.init();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
    });
    await _viewModel.getAllPost();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> showAddPost() async {
    await _remoteConfigService.setupRemoteConfig();
    await _remoteConfigService.defaultSettings();
    await _remoteConfigService.fetchAndActivate();
    setState(() {
      showAddPostDialog = _remoteConfigService.showAddPostDialog();
      if (kDebugMode) {
        print(showAddPostDialog);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              onRefresh: _refreshData,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _viewModel.posts.length,
                  itemBuilder: (context, index) {
                    if (_viewModel.posts.isEmpty) {
                      return const Text("null posts");
                    }
                    return PostCard(
                      post: _viewModel.posts[index],
                      viewModel: _viewModel,
                      refresh: _refreshData,
                    );
                  },
                ),
              ),
            ),
      floatingActionButton: showAddPostDialog
          ? FloatingActionButton(
              onPressed: () async {
                await _showAddPostDialog(context);
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Future<void> selectImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _showAddPostDialog(BuildContext context) async {
    bool imageSelected = false;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "New Post",
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    TextField(
                      controller: _viewModel.titleController,
                      decoration: const InputDecoration(hintText: "Title"),
                      onChanged: (value) {},
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        _viewModel.selectedImages.clear();
                        final List<XFile> pickedFiles =
                            await picker.pickMultiImage();
                        if (pickedFiles.isNotEmpty) {
                          setState(() {
                            _viewModel.selectedImages.addAll(
                                pickedFiles.map((file) => File(file.path)));
                            imageSelected = true;
                          });
                        } else {
                          imageSelected = false;
                        }
                      },
                      child: const Text("Choose Image"),
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: imageSelected,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await _viewModel.submit();
                          _viewModel.selectedImages.clear();
                          _viewModel.titleController.clear();
                          _viewModel.getImageUrl.clear();
                          setState(() {
                            isLoading = false;
                            imageSelected = false;
                          });

                          _refreshData();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                        },
                        child: const Text("Share Post"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
