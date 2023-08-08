import 'package:firebase_app/services/like_service.dart';
import 'package:flutter/material.dart';

class LikeButtonWidget extends StatefulWidget {
  final String postId;
  final String userId;

  const LikeButtonWidget({
    Key? key,
    required this.postId,
    required this.userId,
  }) : super(key: key);

  @override
  State<LikeButtonWidget> createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {
  late final LikeService _likeService;

  bool isLiked = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _likeService = LikeService();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLikeStatus();
    });
  }

  void getLikeStatus() async {
    setState(() {
      isLoading = true;
    });
    var likeModel = await _likeService.getByUserId(widget.userId);
    if (mounted) {
      if (likeModel != null && likeModel.postIds!.contains(widget.postId)) {
        setState(() {
          isLiked = true;
        });
      } else {
        setState(() {
          isLiked = false;
        });
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> toggleLike() async {
    await _likeService.toggleLike(widget.postId, widget.userId);

    if (mounted) {
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SizedBox.shrink()
        : IconButton(
            onPressed: () async {
              await toggleLike();
            },
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.red : null,
            ),
          );
  }
}
