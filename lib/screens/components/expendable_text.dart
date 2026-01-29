import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;
  final TextStyle? style;

  const ExpandableText(
     {
    required this.text,
    super.key,
    this.trimLines = 4,
    this.style,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;
  bool _overflowing = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = widget.style ?? Theme.of(context).textTheme.bodySmall;

    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(text: widget.text, style: textStyle),
          maxLines: widget.trimLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        _overflowing = textPainter.didExceedMaxLines;

        return GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedCrossFade(
              firstChild: Text(
                widget.text,
                maxLines: widget.trimLines,
                overflow: TextOverflow.ellipsis,
                style: textStyle,
              ),
              secondChild: Text(
                widget.text,
                style: textStyle,
              ),
              crossFadeState: _expanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 1000),
            ),
            
          ],
        ),
        );
        
      },
    );
  }
}
