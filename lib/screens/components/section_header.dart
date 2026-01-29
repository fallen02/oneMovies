import 'package:flutter/material.dart';
import 'package:onemovies/utils/icon_fonts.dart';

class SectionHeader extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const SectionHeader({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: colors.onSurface,
            fontFamily: 'Ubuntu',
            fontSize: 20,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'View more',
                style: TextStyle(
                  color: colors.primary,
                  fontFamily: 'Ubuntu',
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(width: 2),
              Padding(
                padding: const EdgeInsets.only(top: 3), // 👈 key line
                child: Icon(Broken.more, size: 14, color: colors.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
