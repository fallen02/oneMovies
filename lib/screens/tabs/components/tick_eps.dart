import 'package:flutter/material.dart';
import 'package:onemovies/utils/icon_fonts.dart';

class TickEps extends StatelessWidget {
  final int sub;
  final int dub;

  const TickEps({super.key, this.sub = 0, this.dub = 0});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (sub == 0 && dub == 0) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (sub > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              color: colors.surface.withValues(alpha: 0.6),
              child: Row(
                children: [
                  Icon(Broken.music, size: 14, color: colors.onSurface),
                  const SizedBox(width: 4),
                  Text(
                    sub.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: colors.onSurface,
                    ),
                  ),
                ],
              ),
            ),

          if (dub > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              color: colors.primary.withValues(alpha: 0.6),
              child: Row(
                children: [
                  Icon(Broken.microphone_2, size: 14, color: colors.onPrimary),
                  const SizedBox(width: 4),
                  Text(
                    dub.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: colors.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
