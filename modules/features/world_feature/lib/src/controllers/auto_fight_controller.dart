import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class AutoFightController {
  final VoidCallback _onActionFight;

  bool _isAutoFight = false;
  Timer? _timer;
  Duration? _delay;
  Tile? _autoFightOnTile;

  bool get isAutoFight => _isAutoFight;
  Tile? get autoFightOnTile => _autoFightOnTile;

  AutoFightController({
    required VoidCallback onActionFight,
  }) : _onActionFight = onActionFight;

  void startAutoFight(Tile autoFightOnTile) {
    _isAutoFight = true;
    _autoFightOnTile = autoFightOnTile;
    _scheduleNextFight();
  }

  void stopAutoFight() {
    _isAutoFight = false;
    _autoFightOnTile = null;
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
