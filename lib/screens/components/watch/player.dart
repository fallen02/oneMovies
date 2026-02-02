import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/models/sources.dart';
import 'package:onemovies/providers/stream_link_provider.dart';
import 'package:onemovies/utils/icon_fonts.dart';

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
        autoDetectFullscreenDeviceOrientation: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          showControls: true,
          enableMute: false,
          enableQualities: true,
          fullscreenEnableIcon: Broken.maximize_circle,
          fullscreenDisableIcon: Broken.maximize_2,
          playIcon: Broken.play,
          pauseIcon: Broken.pause,
          skipBackIcon: Broken.backward_10_seconds,
          skipForwardIcon: Broken.forward_10_seconds,
          pipMenuIcon: Broken.menu_1,
          playbackSpeedIcon: Broken.timer_1,
          subtitlesIcon: Broken.creative_commons,
          audioTracksIcon: Broken.music,
          qualitiesIcon: Broken.video_tick,
          overflowMenuIconsColor: Color(0xffD7263D),
          overflowModalColor: Color(0xff02182B),
          overflowModalTextColor: Colors.white12,
          iconsColor: Color(0xffD7263D),
          enablePlaybackSpeed: false,
        ),
        subtitlesConfiguration: BetterPlayerSubtitlesConfiguration(
          fontSize: 18,
          backgroundColor: Colors.black54,
        ),
      ),
      betterPlayerDataSource: dataSource,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final streamAsync = ref.watch(streamLinkProvider);

    return streamAsync.when(
      loading: () => Container(
        color: Colors.black87,
        child: const AspectRatio(
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
      videoFormat: BetterPlayerVideoFormat.hls,
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Linux; Android 13; Pixel 7 Pro) '
            'AppleWebKit/537.36 (KHTML, like Gecko) '
            'Chrome/137.0.0.0 Mobile Safari/537.36',
        'Accept': '*/*',
        'Connection': 'keep-alive',
        'Referer': source.refferer.toString(),
      },
      subtitles: source.subtitles.map((s) {
        return BetterPlayerSubtitlesSource(
          type: BetterPlayerSubtitlesSourceType.network,
          urls: [s.url],
          name: s.lang.isNotEmpty ? s.lang : 'Subtitles',
          selectedByDefault: s.kind == 'captions',
        );
      }).toList(),
    );
  }
}
