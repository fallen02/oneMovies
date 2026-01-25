import 'package:flutter/material.dart';

enum BadgeType { primary, secondary }


class TickBadge extends StatelessWidget {
  final String text;
  final BadgeType type;
  const TickBadge({super.key, required this.text, this.type = BadgeType.secondary});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    late final Color foreground;
    late final Color background;
    late final Color txtColor;

    switch (type) {
      case BadgeType.primary:
        background = colors.surface;
        foreground = colors.primary;
        txtColor = colors.primary;
        break;
      case BadgeType.secondary:
        background = colors.surface;
        foreground = colors.onSurface;
        txtColor = colors.onSurface;

        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),

      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: foreground, width: 1),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "Ubuntu",
          fontSize: 13,
          color: txtColor,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
