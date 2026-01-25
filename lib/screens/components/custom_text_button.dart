import 'package:flutter/material.dart';

enum CustomTextButtonType { primary, secondary }

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final CustomTextButtonType type;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = CustomTextButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    Color textColor;
    Color backgroundColor;
    FontWeight fontWeight = FontWeight.w600;

    switch (type) {
      case CustomTextButtonType.primary:
        textColor = colors.primary;
        backgroundColor = colors.onSurface;
        break;
      case CustomTextButtonType.secondary:
        textColor = colors.onSurface;
        backgroundColor = colors.primary;
        fontWeight = FontWeight.w500;
    }

    return TextButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        foregroundColor: WidgetStatePropertyAll(textColor),
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
        padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsetsGeometry.fromLTRB(30, 10, 30, 10),
        ),
      ),
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontSize: 20, fontWeight: fontWeight, fontFamily: 'Open Sans')),
    );
  }
}
