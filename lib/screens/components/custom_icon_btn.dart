import 'package:flutter/material.dart';

enum CustomTextButtonType { primary, secondary }

class CustomIconBtn extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final CustomTextButtonType type;

  const CustomIconBtn({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.type = CustomTextButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    late final Color foreground;
    late final Color background;

    switch (type) {
      case CustomTextButtonType.primary:
        background = colors.primary;
        foreground = colors.onPrimary;
        break;
      case CustomTextButtonType.secondary:
        background = colors.surface;
        foreground = colors.onSurface;
        break;
    }

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: background,
        foregroundColor: foreground,
        minimumSize:  const Size(7, 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 7,
          vertical: 5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
