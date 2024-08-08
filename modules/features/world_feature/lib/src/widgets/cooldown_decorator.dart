import 'dart:async';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class CooldownDecorator extends StatefulWidget {
  final DateTime lockoutEndTime;
  final Widget child;
  final VoidCallback onPressed;

  CooldownDecorator({
    required this.lockoutEndTime,
    required this.child,
    required this.onPressed,
  }) : super(key: ValueKey(lockoutEndTime));

  @override
  _CooldownDecoratorState createState() => _CooldownDecoratorState();
}

class _CooldownDecoratorState extends State<CooldownDecorator> {
  late Timer _timer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime = widget.lockoutEndTime.difference(DateTime.now());
        if (_remainingTime.isNegative) {
          _remainingTime = Duration.zero;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Stack(
        children: [
          widget.child,
          if (_remainingTime.inSeconds > 0)
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: AppColors.blackLeatherJacket,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppIcons.clock,
                        // ignore: deprecated_member_use
                        color: AppColors.white,
                        width: 14,
                      ),
                      const AppSpacing.w4(),
                      Text(
                        '${_remainingTime.inSeconds} seconds',
                        style: const TextStyle(color: AppColors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
