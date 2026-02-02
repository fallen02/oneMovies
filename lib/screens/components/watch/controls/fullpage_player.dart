import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:onemovies/screens/components/watch/controls/custom_controls.dart';

class FullscreenPlayerPage extends StatelessWidget {
  final BetterPlayerController controller;

  const FullscreenPlayerPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: CustomControls(controller: controller),
        ),
      ),
    );
  }
}
