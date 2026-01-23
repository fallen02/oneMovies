import 'package:flutter/material.dart';

class TickQuality extends StatelessWidget {
  final String quality;
  const TickQuality({super.key, required this.quality});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1.5),
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        quality,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: colors.primary),
      ),
    );
  }
}
