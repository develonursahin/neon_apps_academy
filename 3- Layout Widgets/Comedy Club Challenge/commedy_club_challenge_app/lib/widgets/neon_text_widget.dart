import 'package:flutter/material.dart';

class NeonTextWidget extends StatelessWidget {
  final String text;
  final Map<String, Color> keywordColors;
  final Color defaultColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double letterSpacing;

  const NeonTextWidget({
    super.key,
    required this.text,
    required this.keywordColors,
    required this.defaultColor,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.letterSpacing = 0,
  });

  @override
  Widget build(BuildContext context) {
    final words = text.split(" ");
    List<InlineSpan> coloredTextSpans = [];

    for (var i = 0; i < words.length; i++) {
      final word = words[i];
      if (keywordColors.containsKey(word)) {
        coloredTextSpans.add(
          TextSpan(
            text: word,
            style: TextStyle(
              shadows: [Shadow(color: keywordColors[word]!, blurRadius: 30)],
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1.5
                ..color = keywordColors[word]!,
            ),
          ),
        );
      } else {
        coloredTextSpans.add(
          TextSpan(
            text: word,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
              color: defaultColor,
            ),
          ),
        );
      }
      if (i < words.length - 1) {
        coloredTextSpans.add(const TextSpan(text: " "));
      }
    }

    return RichText(
      text: TextSpan(
        children: coloredTextSpans,
      ),
    );
  }
}
