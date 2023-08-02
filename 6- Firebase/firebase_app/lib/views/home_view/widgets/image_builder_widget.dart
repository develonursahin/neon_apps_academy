import 'package:firebase_app/views/home_view/home_widget.dart';
import 'package:firebase_app/views/home_view/widgets/dot_indicator_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageBuilderWidget extends StatefulWidget {
  ImageBuilderWidget({
    Key? key,
    required this.widget,
    required this.pageController,
    required this.hasMultipleImages,
    required this.currentPageIndex,
  }) : super(key: key);

  final PostCard widget;
  final PageController pageController;
  final bool hasMultipleImages;
  int currentPageIndex;

  @override
  State<ImageBuilderWidget> createState() => _ImageBuilderWidgetState();
}

class _ImageBuilderWidgetState extends State<ImageBuilderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.widget.post.postImageUrl!.isEmpty
            ? const SizedBox.shrink()
            : SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: widget.pageController,
                      itemCount: widget.widget.post.postImageUrl!.length,
                      onPageChanged: (index) {
                        setState(() {
                          widget.currentPageIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            widget.widget.post.postImageUrl![index],
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                    if (widget.hasMultipleImages)
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 8,
                        child: DotIndicators(
                          totalDots: widget.widget.post.postImageUrl!.length,
                          currentPageIndex: widget.currentPageIndex,
                        ),
                      ),
                  ],
                ),
              ),
      ],
    );
  }
}
