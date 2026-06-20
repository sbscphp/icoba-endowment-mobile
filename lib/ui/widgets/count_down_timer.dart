import 'dart:async';
import 'package:flutter/material.dart';

import '../../core/data/models/remaining_time.dart';

typedef CountdownBuilder =
    Widget Function(BuildContext context, RemainingTime time);

class CountdownTimer extends StatefulWidget {
  final DateTime endTime;
  final CountdownBuilder builder;
  final VoidCallback? onEnd;
  final Duration tick;

  const CountdownTimer({
    super.key,
    required this.endTime,
    required this.builder,
    this.onEnd,
    this.tick = const Duration(seconds: 1),
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late RemainingTime _current;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _current = _calcRemaining();
    _start();
  }

  void _start() {
    _timer = Timer.periodic(widget.tick, (t) {
      final remaining = _calcRemaining();
      if (mounted) {
        setState(() => _current = remaining);
      }
      if (_isZero(remaining)) {
        _timer?.cancel();
        widget.onEnd?.call();
      }
    });
  }

  RemainingTime _calcRemaining() {
    final diff = widget.endTime.difference(DateTime.now());
    return diff.isNegative
        ? RemainingTime.zero
        : RemainingTime.fromDuration(diff);
  }

  bool _isZero(RemainingTime t) =>
      t.days == 0 && t.hours == 0 && t.minutes == 0 && t.seconds == 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _current);
}
