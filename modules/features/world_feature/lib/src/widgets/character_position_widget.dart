import 'dart:math';

import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../bloc/world_bloc.dart';

class CharacterPositionWidget extends StatefulWidget {
  const CharacterPositionWidget();

  @override
  State<CharacterPositionWidget> createState() => _CharacterPositionWidgetState();
}

class _CharacterPositionWidgetState extends State<CharacterPositionWidget> {
  Point<int>? _initialPosition;
  Point<int> _newPosition = const Point(0, 0);

  @override
  void didUpdateWidget(covariant CharacterPositionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final WorldState state = context.read<WorldBloc>().state;
    if (state.selectedCharacter != null) {
      final Point<int> selectedCharacterInitialPosition = Point(
        state.selectedCharacter?.x ?? 0,
        state.selectedCharacter?.y ?? 0,
      );
      if (selectedCharacterInitialPosition != _initialPosition) {
        _initialPosition = selectedCharacterInitialPosition;
        _newPosition = selectedCharacterInitialPosition;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldBloc, WorldState>(
      builder: (BuildContext context, WorldState state) {
        if (state.selectedCharacter == null) {
          return const SizedBox();
        }

        if (_initialPosition == null) {
          _initialPosition = Point(
            state.selectedCharacter?.x ?? 0,
            state.selectedCharacter?.y ?? 0,
          );
          _newPosition = _initialPosition!;
        }

        return Container(
          padding: const EdgeInsets.all(Dimensions.p16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius),
            color: AppColors.blackLeatherJacket.withOpacity(0.95),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Position',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.chineseSilver,
                ),
              ),
              const AppSpacing.h16(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 56,
                            child: Text(
                              'x: ${_newPosition.x}',
                              style: const TextStyle(fontSize: 18, color: AppColors.chineseSilver),
                            ),
                          ),
                          const AppSpacing.w16(),
                          AppElevatedButton(
                            title: '-',
                            onPressed: () {
                              _newPosition = Point(_newPosition.x - 1, _newPosition.y);
                              setState(() {});
                            },
                          ),
                          const AppSpacing.w16(),
                          AppElevatedButton(
                            title: '+',
                            onPressed: () {
                              _newPosition = Point(_newPosition.x + 1, _newPosition.y);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      const AppSpacing.h16(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 56,
                            child: Text(
                              'y: ${_newPosition.y}',
                              style: const TextStyle(fontSize: 18, color: AppColors.chineseSilver),
                            ),
                          ),
                          const AppSpacing.w16(),
                          AppElevatedButton(
                            title: '-',
                            onPressed: () {
                              _newPosition = Point(_newPosition.x, _newPosition.y - 1);
                              setState(() {});
                            },
                          ),
                          const AppSpacing.w16(),
                          AppElevatedButton(
                            title: '+',
                            onPressed: () {
                              _newPosition = Point(_newPosition.x, _newPosition.y + 1);
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const AppSpacing.w16(),
                  SizedBox(
                    width: 120,
                    child: state.isChangingPositon
                        ? const AppProgressIndicator()
                        : AppElevatedButton(
                            title: 'MOVE',
                            onPressed: () {
                              final ChangePositionEvent changePositionEvent = ChangePositionEvent(
                                state.selectedCharacter?.name ?? '',
                                _newPosition,
                              );
                              context.read<WorldBloc>().add(changePositionEvent);
                            },
                          ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
