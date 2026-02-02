import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/providers/episode_provider.dart';
import 'package:onemovies/screens/components/watch/episode_data.dart';
import 'package:onemovies/screens/components/watch/episode_list.dart';
import 'package:onemovies/screens/components/watch/player.dart';

class AnimeWatch extends ConsumerStatefulWidget {
  final String animeId;
  const AnimeWatch({super.key, required this.animeId});

  @override
  ConsumerState<AnimeWatch> createState() => _AnimeWatchState();
}

class _AnimeWatchState extends ConsumerState<AnimeWatch> {
  @override
  Widget build(BuildContext context) {
    final episodesAsync = ref.watch(episodeProvider(widget.animeId));
    // final currentTrack = ref.watch(selectedTrackProvider);

    return episodesAsync.when(
      loading: () => Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) =>
          Scaffold(body: Center(child: Text(error.toString()))),
      data: (epiData) {
        return Scaffold(
          body: Column(
              children: [
                SizedBox(height: 35),
                Player(),
                SizedBox(height: 25),
                EpisodeData(),
                SizedBox(height: 25),
                Expanded(child: EpisodeList(episodes: epiData.episodes)),
              ],
            ),
        );
      },
    );
  }
}
