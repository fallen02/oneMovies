import 'package:flutter/material.dart';

enum InfoScreenBtnType { primary, secondary }

class InfoScreenBtn extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final InfoScreenBtnType type;

  const InfoScreenBtn({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.type = InfoScreenBtnType.primary,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    late final Color foreground;
    late final Color background;

    switch (type) {
      case InfoScreenBtnType.primary:
        background = colors.primary;
        foreground = colors.onPrimary;
        break;
      case InfoScreenBtnType.secondary:
        background = colors.onSurface.withValues(alpha: 0.9);
        foreground = colors.primary;
        break;
    }

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: background,
        foregroundColor: foreground,
        // minimumSize:  const Size(7, 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
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
