import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../bloc/home_bloc.dart';

class CharacterPositionWidget extends StatelessWidget {
  const CharacterPositionWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) {
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
                              'x: ${state.newPosition?.x}',
                              style: const TextStyle(fontSize: 18, color: AppColors.chineseSilver),
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
                            width: 56,
                            child: Text(
                              'y: ${state.newPosition?.y}',
                              style: const TextStyle(fontSize: 18, color: AppColors.chineseSilver),
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
                  SizedBox(
                    width: 120,
                    child: state.isChangingPositon
                        ? const AppProgressIndicator()
                        : AppElevatedButton(
                            title: 'MOVE',
                            onPressed: () {
                              context.read<HomeBloc>().add(const ChangePositionMoveEvent());
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
