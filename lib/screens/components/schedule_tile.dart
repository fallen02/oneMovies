import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/providers/selected_anime_provider.dart';
import 'package:onemovies/screens/anime_info.dart';

class ScheduleTile extends ConsumerWidget {
  final String id;
  final String title;
  final String airingEpisode;
  final String japaneseTitle;
  final String airingTime;

  const ScheduleTile({
    super.key,
    required this.id,
    required this.title,
    required this.japaneseTitle,
    required this.airingEpisode,
    required this.airingTime,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final episodeNumber = airingEpisode.split(' ').length > 1
        ? airingEpisode.split(' ')[1]
        : airingEpisode;

    return InkWell(
      onTap: () {
        ref.read(selectedAnimeIdProvider.notifier).state = id;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AnimeInfoScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            // 🕒 TIME
            Text(
              airingTime,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: colors.primary,
              ),
            ),

            const SizedBox(width: 16),

            // 📺 TITLES
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: colors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    japaneseTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // 🎬 EPISODE BADGE
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: colors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                episodeNumber,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
