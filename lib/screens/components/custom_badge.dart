import 'package:flutter/material.dart';

enum BadgeType{primary, secondary}

class CustomBadge extends StatelessWidget {
  final String text;
  final BadgeType type;

  const CustomBadge({
    super.key,
    required this.text,
    this.type = BadgeType.primary
    });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    late final Color textColor;
    late final Color background;

    switch (type) {
      case BadgeType.primary:
        background = colors.primary;
        textColor = colors.onPrimary;
        break;
      case BadgeType.secondary:
        background = colors.surface;
        textColor = colors.onSurface;
        break;
    }


    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: background.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style:  TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}