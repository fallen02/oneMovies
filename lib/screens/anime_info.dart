import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/providers/info_provider.dart';
import 'package:onemovies/screens/components/auto_marquee_text.dart';
import 'package:onemovies/screens/components/tick_badge.dart';
import 'package:onemovies/screens/components/tick_quality.dart';
import 'package:onemovies/utils/icon_fonts.dart';

class AnimeInfoScreen extends ConsumerStatefulWidget {
  final String id;
  const AnimeInfoScreen({super.key, required this.id});

  @override
  ConsumerState<AnimeInfoScreen> createState() => _AnimeInfoState();
}

class _AnimeInfoState extends ConsumerState<AnimeInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final infoAsync = ref.watch(infoProvider(widget.id));
    final colors = Theme.of(context).colorScheme;

    return infoAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) =>
          Scaffold(body: Center(child: Text(error.toString()))),
      data: (animeInfo) {
        final imageProvider = NetworkImage(animeInfo.image);

        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async{
              ref.refresh(infoProvider(widget.id));
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
                          TickBadge(
                            text: animeInfo.status,
                            type: BadgeType.primary,
                          ),
                          TickBadge(
                            text: animeInfo.totalEps,
                            type: BadgeType.primary,
                          ),
                        ],
                      ),

                      Row(
                        spacing: 10,
                        children: [
                          Text(
                            animeInfo.season.split(' ')[1],
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          TickBadge(text: animeInfo.pgRationg),
                          TickBadge(text: animeInfo.type.name),

                          TickBadge(
                            text: animeInfo.quality,
                            type: BadgeType.primary,
                          ),
                          if (animeInfo.hasSub)
                            TickBadge(text: "SUB", type: BadgeType.primary),
                          if (animeInfo.hasDub)
                            TickBadge(text: "DUB", type: BadgeType.primary),

                          TickBadge(
                            text: animeInfo.duration,
                            type: BadgeType.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),)
        );
      },
    );
  }
}
