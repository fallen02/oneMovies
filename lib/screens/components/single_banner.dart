import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/models/home.dart';
import 'package:onemovies/providers/selected_anime_provider.dart';
import 'package:onemovies/screens/anime_info.dart';
import 'package:onemovies/screens/components/custom_icon_btn.dart';
import 'package:onemovies/screens/components/tick_eps.dart';
import 'package:onemovies/screens/components/tick_icon.dart';
import 'package:onemovies/screens/components/tick_quality.dart';
import 'package:onemovies/utils/icon_fonts.dart';

class SingleBanner extends ConsumerStatefulWidget {
  final Spotlight spotlight;
  const SingleBanner({super.key, required this.spotlight});

  @override
  ConsumerState<SingleBanner> createState() => _SingleBannerState();
}

class _SingleBannerState extends ConsumerState<SingleBanner> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final spotlight = widget.spotlight;
    return InkWell(
      onTap: () {
        // print(spotlight.id);
        ref.read(selectedAnimeIdProvider.notifier).state = spotlight.id;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AnimeInfoScreen()),
        );
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            // borderRadius: BorderRadius.circular(16),
            child: Image.network(spotlight.banner, fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [const Color.fromARGB(68, 0, 0, 0), Colors.black87],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 5,
            left: 10,
            right: 10,
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    spotlight.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: colors.primary,
                    ),
                  ),
                  Text(
                    spotlight.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.white70),
                  ),

                  SizedBox(height: 10),
                  Text(
                    spotlight.genres.join(' • '),
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Ubuntu',
                      letterSpacing: 0.1,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    spacing: 10,
                    children: [
                      TickIcon(
                        text: spotlight.type.name,
                        icon: Broken.play_circle,
                      ),
                      // TickIcon(text: spotlight.duration, icon: Broken.clock),
                      TickIcon(
                        text: spotlight.releaseDate,
                        icon: Broken.calendar,
                      ),
                      // SizedBox(width: 15,),
                      TickQuality(quality: spotlight.quality),
                      TickEps(sub: spotlight.sub, dub: spotlight.dub),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      CustomIconBtn(
                        text: 'Watch Now',
                        icon: Broken.play,
                        onPressed: () {
                          ref.read(selectedAnimeIdProvider.notifier).state =
                              spotlight.id;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AnimeInfoScreen(),
                            ),
                          );
                        },
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
