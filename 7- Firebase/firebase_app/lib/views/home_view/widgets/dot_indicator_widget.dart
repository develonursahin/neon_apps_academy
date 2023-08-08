import 'package:flutter/material.dart';

class DotIndicators extends StatelessWidget {
  final int totalDots;
  final int currentPageIndex;

  const DotIndicators({
    super.key,
    required this.totalDots,
    required this.currentPageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < totalDots; i++)
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentPageIndex == i ? Colors.blue : Colors.grey,
            ),
          ),
      ],
    );
  }
}
