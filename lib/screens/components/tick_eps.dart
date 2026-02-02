
import 'package:flutter/material.dart';
import 'package:onemovies/utils/icon_fonts.dart';

enum EpsBadgeType { normal, info }

class TickEps extends StatelessWidget {
  final int sub;
  final int dub;
  final int eps;
  final EpsBadgeType? type;

  const TickEps({
    super.key,
    this.sub = 0,
    this.dub = 0,
    this.eps = 0,
    this.type = EpsBadgeType.normal,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final double horizontal;
    final double vertical;

    switch (type) {
      case EpsBadgeType.normal:
        horizontal = 6;
        vertical = 2;
        break;

      case EpsBadgeType.info:
        horizontal = 10;
        vertical = 5;
        break;

      default:
        horizontal = 6;
        vertical = 2;
        break;
    }

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
              padding:  EdgeInsets.symmetric(
                horizontal: horizontal,
                vertical: vertical,
              ),
              color: Colors.green.withValues(alpha: 0.5),
              child: Row(
                children: [
                  Icon(
                    Broken.creative_commons,
                    size: 14,
                    color: colors.onSurface,
                  ),
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
              padding:  EdgeInsets.symmetric(
                horizontal: horizontal,
                vertical: vertical,
              ),
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

          if (eps > 0)
            Container(
              padding:  EdgeInsets.symmetric(
                horizontal: horizontal,
                vertical: vertical,
              ),
              color: const Color.fromARGB(19, 255, 255, 255),
              child: Row(
                children: [
                  Icon(Broken.music, size: 14, color: colors.onPrimary),
                  const SizedBox(width: 4),
                  Text(
                    eps.toString(),
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
