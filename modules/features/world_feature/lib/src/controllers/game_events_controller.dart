import 'dart:async';

import 'package:flutter/material.dart';

class GameEventsController {
  final VoidCallback onGameEvents;
  Timer? _timer;
  Duration? _delay;

  GameEventsController({
    required this.onGameEvents,
  });

  void startPeriodicGameUpdates() {
    _scheduleNextFight();
  }

  void stopPeriodicGameUpdates() {
    _timer?.cancel();
  }

  void setDelay(Duration delay) {
    _delay = delay;
    _scheduleNextFight();
  }

  void _scheduleNextFight() {
    _timer?.cancel();

    final Duration? delay = _delay;
    if (delay == null) {
      return;
    }

    _timer = Timer(delay, () async {
      onGameEvents();
      _scheduleNextFight();
    });
  }
}
