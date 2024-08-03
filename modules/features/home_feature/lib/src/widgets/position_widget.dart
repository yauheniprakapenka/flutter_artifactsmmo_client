import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../bloc/home_bloc.dart';

class PositionWidget extends StatelessWidget {
  const PositionWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) {
        return Container(
          padding: const EdgeInsets.all(Dimensions.p16),
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Position',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
                            width: 48,
                            child: Text(
                              'x: ${state.newPosition?.x}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const AppSpacing.w16(),
                          AppElevatedButton(
                            title: '-',
                            onPressed: () {
                              context.read<HomeBloc>().add(const ChangePositionXDecrementEvent());
                            },
                          ),
                          const AppSpacing.w16(),
                          AppElevatedButton(
                            title: '+',
                            onPressed: () {
                              context.read<HomeBloc>().add(const ChangePositionXIncrementEvent());
                            },
                          ),
                        ],
                      ),
                      const AppSpacing.h16(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 48,
                            child: Text(
                              'y: ${state.newPosition?.y}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                          const AppSpacing.w16(),
                          AppElevatedButton(
                            title: '-',
                            onPressed: () {
                              context.read<HomeBloc>().add(const ChangePositionYDecrementEvent());
                            },
                          ),
                          const AppSpacing.w16(),
                          AppElevatedButton(
                            title: '+',
                            onPressed: () {
                              context.read<HomeBloc>().add(const ChangePositionYIncrementEvent());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const AppSpacing.w16(),
                  AppElevatedButton(
                    title: 'MOVE',
                    onPressed: () {
                      context.read<HomeBloc>().add(const ChangePositionMoveEvent());
                    },
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
