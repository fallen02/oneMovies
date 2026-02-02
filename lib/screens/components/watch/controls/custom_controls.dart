import 'dart:async';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onemovies/providers/selected_anime_episode_provider.dart';
import 'package:onemovies/utils/icon_fonts.dart';

class CustomControls extends ConsumerStatefulWidget {
  final BetterPlayerController controller;

  const CustomControls({super.key, required this.controller});

  @override
  ConsumerState<CustomControls> createState() => _CustomControlsState();
}

class _CustomControlsState extends ConsumerState<CustomControls> {
  bool _controlsVisible = true;
  bool _buffering = false;

  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  Timer? _hideTimer;
  late final void Function(BetterPlayerEvent) _eventListener;

  int _lastSecond = -1; // throttle progress updates

  @override
  void initState() {
    super.initState();

    _eventListener = (event) {
      if (!mounted) return;

      switch (event.betterPlayerEventType) {
        case BetterPlayerEventType.progress:
          final pos = event.parameters?['progress'] as Duration?;
          final dur = event.parameters?['duration'] as Duration?;

          if (pos == null || dur == null) return;

          if (pos.inSeconds != _lastSecond) {
            _lastSecond = pos.inSeconds;
            setState(() {
              _position = pos;
              _duration = dur;
            });
          }
          break;

        case BetterPlayerEventType.bufferingStart:
          setState(() => _buffering = true);
          break;

        case BetterPlayerEventType.bufferingEnd:
          setState(() => _buffering = false);
          break;

        default:
          break;
      }
    };

    widget.controller.addEventsListener(_eventListener);
    _startAutoHide();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    widget.controller.removeEventsListener(_eventListener);
    super.dispose();
  }

  void _toggleControls() {
    setState(() => _controlsVisible = !_controlsVisible);
    _startAutoHide();
  }

  void _startAutoHide() {
    _hideTimer?.cancel();

    if (widget.controller.isPlaying() != true) return;

    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _controlsVisible = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxSeconds = _duration.inSeconds.toDouble();
    final currentSeconds = _position.inSeconds.toDouble();

    final currentEpisode = ref.watch(selectedAnimeEpisodeProvider);

    final String currentTitle = currentEpisode != null
        ? currentEpisode.title
        : '';

    return GestureDetector(
      onTap: _toggleControls,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        children: [
          BetterPlayer(controller: widget.controller),

          if (_buffering)
            const Center(child: CircularProgressIndicator(color: Colors.green)),

          // 🎛 Controls
          if (_controlsVisible)
            Positioned.fill(
              child: Container(
                color: Colors.black38,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _topBar(context, currentTitle),
                    // _centerControls(),
                    _bottomControls(
                      maxSeconds: maxSeconds,
                      currentSeconds: currentSeconds,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ─────────────────── UI PARTS ───────────────────

  Widget _topBar(BuildContext context, String episodeTitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Broken.arrow_left_2, color: Colors.white),
            onPressed: () => Navigator.maybePop(context),
          ),

          Expanded(
            child: Text(
              episodeTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _centerControls() {
  //   final isPlaying = widget.controller.isPlaying() == true;

  //   return GestureDetector(
  //     onTap: () {
  //       isPlaying ? widget.controller.pause() : widget.controller.play();

  //       setState(() {});
  //       _startAutoHide();
  //     },
  //     child: Icon(
  //       isPlaying ? Icons.pause_circle : Icons.play_circle,
  //       size: 72,
  //       color: Colors.white,
  //     ),
  //   );
  // }

  Widget _bottomControls({
    required double maxSeconds,
    required double currentSeconds,
  }) {
    final isPlaying = widget.controller.isPlaying() == true;

    void seekForward15s() {
      final pos = widget.controller.videoPlayerController?.value.position;
      final dur = widget.controller.videoPlayerController?.value.duration;

      if (pos == null || dur == null) return;

      final target = pos + const Duration(seconds: 15);
      widget.controller.seekTo(target > dur ? dur : target);
    }

    void seekBackward15s() {
      final pos = widget.controller.videoPlayerController?.value.position;
      if (pos == null) return;

      final target = pos - const Duration(seconds: 15);
      widget.controller.seekTo(target < Duration.zero ? Duration.zero : target);
    }

    void toggleFullscreen() {
      if (widget.controller.isFullScreen == true) {
        widget.controller.exitFullScreen();
      } else {
        widget.controller.enterFullScreen();
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        children: [
          Row(
            spacing: 5,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _fmt(_position),
                style: const TextStyle(color: Colors.white),
              ),
              Expanded(
                child: Slider(
                  value: maxSeconds == 0
                      ? 0
                      : currentSeconds.clamp(0, maxSeconds),
                  max: maxSeconds == 0 ? 1 : maxSeconds,

                  onChanged: (v) {
                    widget.controller.seekTo(Duration(seconds: v.toInt()));
                  },
                ),
              ),

              Text(
                _fmt(_duration),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  isPlaying
                      ? widget.controller.pause()
                      : widget.controller.play();

                  setState(() {});
                  _startAutoHide();
                },
                child: Icon(Broken.card, size: 18),
              ),

              Wrap(
                spacing: 10,
                children: [
                  GestureDetector(
                    onTap: seekBackward15s,
                    child: Icon(
                      Broken.backward_15_seconds,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      isPlaying
                          ? widget.controller.pause()
                          : widget.controller.play();

                      setState(() {});
                      _startAutoHide();
                    },
                    child: Icon(
                      isPlaying ? Broken.pause : Broken.play,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  GestureDetector(
                    onTap: seekForward15s,
                    child: Icon(
                      Broken.forward_15_seconds,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: toggleFullscreen,
                child: Icon(
                  Broken.maximize_circle,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _fmt(Duration d) {
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
