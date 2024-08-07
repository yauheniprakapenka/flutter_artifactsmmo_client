import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class FightActionWidget extends StatelessWidget {
  final VoidCallback onFightPressed;

  const FightActionWidget({
    required this.onFightPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius),
        color: AppColors.eerieBlack,
      ),
      padding: const EdgeInsets.all(Dimensions.p12),
      child: InkWell(
        onTap: () {
          onFightPressed();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Fight',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const AppSpacing.w4(),
            SvgPicture.asset(
              AppIcons.fight.assetPath,
              width: 22,
              // ignore: deprecated_member_use
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
