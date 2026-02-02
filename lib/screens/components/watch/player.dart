import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/models/sources.dart';
import 'package:onemovies/providers/stream_link_provider.dart';

class Player extends ConsumerStatefulWidget {
  const Player({super.key});

  @override
  ConsumerState<Player> createState() => _PlayerState();
}

class _PlayerState extends ConsumerState<Player> {
  BetterPlayerController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _load(ISource source) {
    _controller?.dispose();

    final dataSource = _buildDataSource(source);

    _controller = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoPlay: true,
        fit: BoxFit.contain,
        aspectRatio: 16 / 9,
        subtitlesConfiguration: BetterPlayerSubtitlesConfiguration(
          fontSize: 15,
          backgroundColor: Colors.black54,
        ),
        autoDetectFullscreenDeviceOrientation: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          showControls: true,
        ),
      ),
      betterPlayerDataSource: dataSource,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final streamAsync = ref.watch(streamLinkProvider);
    // final currentTrack = ref.watch(selectedTrackProvider);
    // print(streamAsync.asData);

    return streamAsync.when(
      // loading: () => const Center(child: CircularProgressIndicator()),
      loading: () => Container(
        decoration: BoxDecoration(color: Colors.black87),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (source) {
        if (source == null || source.sources.isEmpty) {
          return const Center(child: Text('No playable source'));
        }

        if (_controller == null ||
            _controller!.betterPlayerDataSource?.url !=
                source.sources.first.url) {
          _load(source);
        }

        return AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer(controller: _controller!),
        );
      },
    );
  }

  BetterPlayerDataSource _buildDataSource(ISource source) {
    final video = source.sources.firstWhere(
      (s) => s.isM3U8,
      orElse: () => source.sources.first,
    );

    return BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      video.url,
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Linux; Android 13; Pixel 7 Pro) '
            'AppleWebKit/537.36 (KHTML, like Gecko) '
            'Chrome/137.0.0.0 Mobile Safari/537.36',
        'Accept': '*/*',
        // 'Referer': current,
        'Connection': 'keep-alive',
        // 'Origin': 'https://your-site.com',
        'Referer': source.refferer.toString(),
      },
      videoFormat: BetterPlayerVideoFormat.hls,
      subtitles: source.subtitles.map((s) {
        return BetterPlayerSubtitlesSource(
          type: BetterPlayerSubtitlesSourceType.network,
          urls: [s.url],
          name: s.lang != '' ? s.lang : "Thumbnail",
          selectedByDefault: s.kind == 'captions',
        );
      }).toList(),
    );
  }
}
