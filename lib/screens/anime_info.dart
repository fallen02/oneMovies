import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/providers/info_provider.dart';
import 'package:onemovies/providers/selected_anime_provider.dart';
import 'package:onemovies/screens/anime_watch.dart';
import 'package:onemovies/screens/components/auto_marquee_text.dart';
import 'package:onemovies/screens/components/expendable_text.dart';
import 'package:onemovies/screens/components/genre_badge.dart';
import 'package:onemovies/screens/components/info_screen_btn.dart';
import 'package:onemovies/screens/components/more_season.dart';
import 'package:onemovies/screens/components/related_anime_section.dart';

import 'package:onemovies/screens/components/tick_badge.dart';
import 'package:onemovies/screens/components/tick_eps.dart';
import 'package:onemovies/utils/icon_fonts.dart';

class AnimeInfoScreen extends ConsumerStatefulWidget {
  const AnimeInfoScreen({super.key});

  @override
  ConsumerState<AnimeInfoScreen> createState() => _AnimeInfoState();
}

class _AnimeInfoState extends ConsumerState<AnimeInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final animeId = ref.watch(selectedAnimeIdProvider);
    if (animeId == null) {
      return const Scaffold(body: Center(child: Text('No Anime Selected')));
    }
    final infoAsync = ref.watch(infoProvider(animeId));
    final colors = Theme.of(context).colorScheme;

    return infoAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) =>
          Scaffold(body: Center(child: Text(error.toString()))),
      data: (animeInfo) {
        final imageProvider = NetworkImage(animeInfo.poster);
        final watchId = '${animeInfo.id}\$=${animeInfo.aniId}';
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              ref.refresh(infoProvider(animeId));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🎬 HERO HEADER
                  ClipRect(
                    child: SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // 🔹 Background image
                          Image(image: imageProvider, fit: BoxFit.cover),

                          // 🔹 Blur + dark overlay
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                            child: Container(
                              color: colors.surface.withValues(alpha: 0.5),
                            ),
                          ),

                          // 🔹 Foreground poster
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image(
                                image: imageProvider,
                                height: 300, // 👈 smaller = depth
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).padding.top + 8,
                            left: 8,
                            child: Material(
                              color: Colors.black.withValues(alpha: 0.4),
                              shape: const CircleBorder(),
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                onTap: () => Navigator.of(context).pop(),
                                child: const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Broken.arrow_left_2,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            Expanded(
                              child: AutoMarqueeText(
                                animeInfo.title,
                                style: const TextStyle(
                                  fontFamily: 'Ubuntu',
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 2),

                        Row(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              spacing: 10,
                              children: [
                                TickBadge(
                                  text: animeInfo.type.name,
                                  type: BadgeType.primary,
                                ),
                                TickBadge(
                                  text: animeInfo.rated == '?'
                                      ? 'Unknown'
                                      : animeInfo.rated,
                                  type: BadgeType.primary,
                                ),
                                Text(
                                  animeInfo.season,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'Ubuntu',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            TickEps(
                              dub: animeInfo.dubEps,
                              sub: animeInfo.subEps,
                              type: EpsBadgeType.info,
                            ),
                          ],
                        ),

                        SizedBox(height: 5),

                        // Btns
                        Row(
                          spacing: 10,
                          children: [
                            Expanded(
                              child: InfoScreenBtn(
                                icon: Broken.play,
                                text: "Watch Now",
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AnimeWatch(animeId: watchId,),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: InfoScreenBtn(
                                icon: Broken.document_download,
                                text: "Download",
                                onPressed: () {},
                                type: InfoScreenBtnType.secondary,
                              ),
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ExpandableText(text: animeInfo.description),

                            SizedBox(height: 10),

                            Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              runAlignment: WrapAlignment.start,
                              children: animeInfo.genres
                                  .map(
                                    (genre) => GenreBadge(
                                      genre: genre,
                                      text: genre,
                                      type: GenreBadgetype.primary,
                                    ),
                                  )
                                  .toList(),
                            ),

                            SizedBox(height: 20),

                            if (animeInfo.relations.isNotEmpty)
                              MoreSeasonSection(seasons: animeInfo.relations),

                            // SizedBox(height: 20,),
                            // RelatedAnimeSection(seasons: animeInfo.relatedAnime, headingTxt: "Related Anime"),
                            SizedBox(height: 20),
                            RelatedAnimeSection(
                              seasons: animeInfo.recommendations,
                              headingTxt: "Recommended Anime",
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
