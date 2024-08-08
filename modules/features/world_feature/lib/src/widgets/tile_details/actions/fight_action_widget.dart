import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class FightActionWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const FightActionWidget({
    required this.onPressed,
  });

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
            const Text(
              'Fight',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const AppSpacing.w4(),
            SvgPicture.asset(
              AppIcons.fight,
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
