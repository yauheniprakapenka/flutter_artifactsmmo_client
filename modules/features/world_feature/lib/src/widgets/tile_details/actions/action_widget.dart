import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class ActionWidget extends StatelessWidget {
  final String title;
  final String iconAssetPath;
  final VoidCallback onPressed;

  const ActionWidget({
    required this.title,
    this.iconAssetPath = '',
    required this.onPressed,
  });

  factory ActionWidget.move({
    required VoidCallback onPressed,
  }) {
    return ActionWidget(
      onPressed: onPressed,
      title: 'Move',
      iconAssetPath: AppIcons.move,
    );
  }

  factory ActionWidget.fight({
    required VoidCallback onPressed,
  }) {
    return ActionWidget(
      onPressed: onPressed,
      title: 'Fight',
      iconAssetPath: AppIcons.fight,
    );
  }

  factory ActionWidget.completeTask({
    required VoidCallback onPressed,
  }) {
    return ActionWidget(
      onPressed: onPressed,
      title: 'Complete task',
      iconAssetPath: AppIcons.complete,
    );
  }

  factory ActionWidget.newTask({
    required VoidCallback onPressed,
  }) {
    return ActionWidget(
      onPressed: onPressed,
      title: 'New task',
      iconAssetPath: AppIcons.question,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius),
          color: AppColors.eerieBlack,
        ),
        padding: const EdgeInsets.all(Dimensions.p12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            iconAssetPath.isEmpty
                ? const SizedBox()
                : Row(
                    children: [
                      const AppSpacing.w8(),
                      SvgPicture.asset(
                        iconAssetPath,
                        width: 18,
                        // ignore: deprecated_member_use
                        color: AppColors.white,
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
