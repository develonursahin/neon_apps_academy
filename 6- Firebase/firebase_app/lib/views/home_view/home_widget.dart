import 'package:firebase_app/models/comment_model.dart';
import 'package:firebase_app/models/post_model.dart';
import 'package:firebase_app/models/user_model.dart';
import 'package:firebase_app/services/auth_service.dart';
import 'package:firebase_app/services/comment_service.dart';
import 'package:firebase_app/services/like_service.dart';
import 'package:firebase_app/services/post_service.dart';
import 'package:firebase_app/services/user_service.dart';
import 'package:firebase_app/views/home_view/home_viewmodel.dart';
import 'package:firebase_app/views/home_view/widgets/image_builder_widget.dart';
import 'package:firebase_app/views/home_view/widgets/like_button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  final HomeViewModel viewModel;
  final Future<void> Function() refresh;
  const PostCard({
    Key? key,
    required this.post,
    required this.viewModel,
    required this.refresh,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isReadMore = false;
  int _currentPageIndex = 0;
  bool isLoading = false;
  bool isLiked = false;
  Color statusColor = Colors.red;
  final PageController _pageController = PageController();
  final PostService _postService = PostService();
  late final UserService _userService;
  final CommentService _commentService = CommentService();
  late final AuthService _authService;
  late final UserModel userModel;
  List<CommentModel> comments = [];
  TextEditingController commentController = TextEditingController();
  final LikeService _likeService = LikeService();

  @override
  void initState() {
    super.initState();
    _postService.init();
    _commentService.init();
    _userService = UserService();
    _authService = AuthService();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLikes();
    });
  }

  void authStateChanges() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        userModel.setOnlineStatus(true);
        statusColor = Colors.green;
      } else {
        userModel.setOnlineStatus(false);
        statusColor = Colors.red;
      }
    });
  }

  void handleLikeButtonPressed() async {
    String currentUserId = _authService.currentUser!.uid;
    if (isLiked) {
      await _likeService.unlikePost(widget.post.id!, currentUserId);
    } else {
      await _likeService.likePost(widget.post.id!, currentUserId);
    }
    await getLikes();
  }

  Future<UserModel> getUserById(String id) async {
    var userModel = await _userService.getById(_authService.currentUser!.uid);
    return userModel;
  }

  Future<void> getLikes() async {
    var likes = await _likeService.getByUserId(_authService.currentUser!.uid);
    bool isUserLikeFound = false;

    if (likes != null &&
        likes.postIds != null &&
        likes.postIds!.contains(widget.post.id)) {
      isUserLikeFound = true;
    }

    if (mounted) {
      setState(() {
        isLiked = isUserLikeFound;
      });
    }
  }

  Future<void> getComments() async {
    List<CommentModel> list =
        await _commentService.getByPostId(widget.post.id!);
    if (mounted) {
      setState(() {
        comments.clear();
        comments.addAll(list);
      });
    }
  }

  Future<void> createComment(String postId) async {
    var userModel = await getUserById(_authService.currentUser!.uid);
    CommentModel commentModel = CommentModel(
      id: '',
      userName: userModel.userName,
      commentText: commentController.text.trim(),
      createdAt: DateTime.now(),
      postId: postId,
    );
    await _commentService.create(commentModel);
    commentController.clear();
    if (mounted) {
      setState(() {
        comments.add(commentModel);
      });
    }
  }

  String formatTimeElapsed(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).round();
      return '$months month${months > 1 ? 's' : ''}';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays}d';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes}m';
    } else {
      return 'Just now';
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void changeIndex(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  Future<void> deletePost() async {
    await _postService.delete(widget.post.id!);
  }

  bool get hasMultipleImages =>
      widget.post.postImageUrl != null && widget.post.postImageUrl!.length > 1;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SizedBox.shrink()
        : Card(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder(
                      future: widget.viewModel.getUserById(widget.post.userId!),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              snapshot.data!.userImageUrl!),
                                          foregroundColor: statusColor,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          child: ColoredBox(
                                            color: statusColor,
                                            child: Icon(
                                              size: 16,
                                              Icons.add,
                                              color: statusColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Text(snapshot.data!.userName!),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(formatTimeElapsed(
                                      widget.post.createdAt!)),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.access_time_outlined,
                                    size: 20,
                                  ),
                                  PopupMenuButton<int>(
                                    itemBuilder: (context) {
                                      bool isCurrentUserPostOwner =
                                          widget.post.userId ==
                                              _authService.currentUser!.uid;
                                      if (isCurrentUserPostOwner) {
                                        return [
                                          const PopupMenuItem<int>(
                                            value: 0,
                                            child: Text("Delete"),
                                          ),
                                        ];
                                      } else {
                                        return [];
                                      }
                                    },
                                    onSelected: (value) async {
                                      if (value == 0) {
                                        await deletePost();
                                        await widget.refresh();
                                      }
                                    },
                                  )
                                ],
                              ),
                            ],
                          );
                        }
                        return const SizedBox.shrink();
                      }),
                ),
                ImageBuilderWidget(
                    widget: widget,
                    pageController: _pageController,
                    hasMultipleImages: hasMultipleImages,
                    currentPageIndex: _currentPageIndex),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          LikeButtonWidget(
                              postId: widget.post.id!,
                              userId: _authService.currentUser!.uid),
                          IconButton(
                            onPressed: () async {
                              await getComments();
                              // ignore: use_build_context_synchronously
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                    builder: (context, setState) {
                                      return Container(
                                        color: Colors.white,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                                child: ListView.builder(
                                                  itemCount: comments.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var comment =
                                                        comments[index];
                                                    return ListTile(
                                                      title: Text(
                                                          comment.commentText!),
                                                      subtitle: Text(
                                                          comment.userName!),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: TextField(
                                                      controller:
                                                          commentController,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      await createComment(
                                                          widget.post.id!);
                                                      setState(() {});
                                                    },
                                                    icon:
                                                        const Icon(Icons.send),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.mode_comment_outlined),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isReadMore = !isReadMore;
                            });
                          },
                          child: Text(
                            widget.post.title!,
                            overflow: isReadMore ? null : TextOverflow.ellipsis,
                            maxLines: isReadMore ? null : 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
