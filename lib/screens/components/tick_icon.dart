import 'package:flutter/material.dart';

class TickIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  const TickIcon({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      spacing: 2,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 15, color: colors.primary),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
