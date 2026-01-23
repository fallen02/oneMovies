import 'dart:async';
import 'package:flutter/material.dart';

class SpotlightBanner extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  const SpotlightBanner({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  State<SpotlightBanner> createState() => _SpotlightBannerState();
}

class _SpotlightBannerState extends State<SpotlightBanner> {
  late final PageController _controller;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _controller = PageController(viewportFraction: 1);

    _timer = Timer.periodic(
      const Duration(seconds: 4),
      (_) {
        if (!_controller.hasClients) return;

        _currentPage =
            (_currentPage + 1) % widget.itemCount;

        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.itemCount,
        onPageChanged: (index) {
          _currentPage = index;
          _timer?.cancel();
          _timer = Timer.periodic(const Duration(seconds: 4), (_){
            if(!_controller.hasClients) return;
            _currentPage = (_currentPage + 1) % widget.itemCount;
            _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
          });
        },
        itemBuilder: widget.itemBuilder,
      ),
    );
  }
}
