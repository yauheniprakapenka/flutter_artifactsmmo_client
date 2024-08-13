import 'dart:async';

import 'package:flutter/material.dart';

class AutoFightController {
  bool _isAutoFight = false;
  Timer? _timer;
  Duration? _delay;

  bool get isAutoFight => _isAutoFight;

  final VoidCallback _onActionFight;

  AutoFightController({
    required VoidCallback onActionFight,
  }) : _onActionFight = onActionFight;

  void startAutoFight() {
    _isAutoFight = true;
    _scheduleNextFight();
  }

  void stopAutoFight() {
    _isAutoFight = false;
    _timer?.cancel();
  }

  void setDelay(Duration delay) {
    _delay = delay;
    if (_isAutoFight) {
      _scheduleNextFight();
    }
  }

  void _scheduleNextFight() {
    _timer?.cancel();

    final Duration? delay = _delay;
    if (delay == null) {
      return;
    }

    _timer = Timer(delay, () async {
      if (_isAutoFight) {
        _onActionFight();
        _scheduleNextFight();
      }
    });
  }
}
