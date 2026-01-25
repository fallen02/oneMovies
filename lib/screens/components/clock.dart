import 'dart:async';

import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late Timer _timer;
  DateTime _now = DateTime.now();
@override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        setState(() {
          _now = DateTime.now();
        });
      },
    );
  }
   @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    final second = time.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }

  @override
  Widget build(BuildContext context) {
    return  Text(
      _formatTime(_now),
      style: const TextStyle(
        fontFamily: 'Open Sans',
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    );
  }
}