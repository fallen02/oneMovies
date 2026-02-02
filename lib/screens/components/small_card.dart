import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/providers/selected_anime_provider.dart';
import 'package:onemovies/screens/anime_info.dart';
import 'package:onemovies/screens/components/custom_badge.dart';

class SmallCard extends ConsumerWidget {
  final String id;
  final String title;
  final String poster;
  final String? epiNo;
  final String? type;
  final String? runtime;
  final bool isActive;
  final bool createNavigation;

  const SmallCard({
    super.key,
    required this.id,
    required this.title,
    required this.poster,
    this.epiNo,
    this.runtime,
    this.type,
    this.isActive = false,
    this.createNavigation = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final Color textColor = isActive ? colors.primary : Colors.white70;

    return ClipRRect(
      child: InkWell(
        borderRadius: BorderRadius.circular(5),
      onTap: () {
        ref.read(selectedAnimeIdProvider.notifier).state = id;
        if (createNavigation) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AnimeInfoScreen()),
          );
        }
      },
      child: Container(
        width: 120, // 👈 REQUIRED for horizontal slider
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Stack(
            children: [
              Image.network(
                poster,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  return progress == null
                      ? child
                      : Container(color: colors.secondary);
                },
                errorBuilder: (_, __, ___) => Container(
                  color: colors.surface,
                  child: const Icon(Icons.broken_image),
                ),
              ),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black],
                    ),
                  ),
                ),
              ),

              // 📝 Title
              Positioned(
                left: 5,
                right: 5,
                bottom: 5,
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Ubuntu',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ),
              ),

              // 🔖 Episode badge
              if (epiNo != null)
                Positioned(top: 6, left: 6, child: CustomBadge(text: epiNo!)),

              // 🎬 Type badge
              if (type != null)
                Positioned(
                  top: 6,
                  right: 6,
                  child: CustomBadge(text: type!, type: BadgeType.secondary),
                ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
