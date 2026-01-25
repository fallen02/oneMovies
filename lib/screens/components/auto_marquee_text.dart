import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class AutoMarqueeText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const AutoMarqueeText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(text: text, style: style),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout();

        final isOverflowing = textPainter.width > constraints.maxWidth;

        return SizedBox(
          height: style?.fontSize ?? 14 + 4,
          child: isOverflowing
              ? Marquee(
                  text: text,
                  style: style,
                  velocity: 30,
                  blankSpace: 24,
                  pauseAfterRound: const Duration(seconds: 1),
                )
              : Text(
                  text,
                  style: style,
                  overflow: TextOverflow.ellipsis,
                ),
        );
      },
    );
  }
}
