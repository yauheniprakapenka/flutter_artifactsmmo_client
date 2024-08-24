import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import '../../bloc/world_bloc.dart';
import 'game_event_details_widget.dart';

class GameEventsWidget extends StatelessWidget {
  const GameEventsWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldBloc, WorldState>(
      builder: (BuildContext context, WorldState state) {
        return Positioned(
          right: Dimensions.edgeInset,
          top: Dimensions.edgeInset,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: Column(
              key: ValueKey<int>(state.gameEvents.length),
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...state.gameEvents.map((GameEvent gameEvent) {
                  return AnimatedGameEventItem(
                    key: ValueKey<GameEvent>(gameEvent),
                    gameEvent: gameEvent,
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AnimatedGameEventItem extends StatelessWidget {
  final GameEvent gameEvent;

  const AnimatedGameEventItem({
    super.key,
    required this.gameEvent,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (BuildContext context, double value, Widget? child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(50 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(Dimensions.p16),
        decoration: BoxDecoration(
          color: AppColors.darkJungleGreen,
          borderRadius: BorderRadius.circular(Dimensions.radius),
        ),
        margin: const EdgeInsets.only(bottom: 20),
        child: GameEventDetailsWidget(gameEvent: gameEvent),
      ),
    );
  }
}
