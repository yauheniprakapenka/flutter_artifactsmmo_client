import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class FocusButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback onPressed;

  const FocusButton({
    required this.assetPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(Dimensions.p12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius),
          color: AppColors.blackLeatherJacket.withOpacity(0.95),
        ),
        child: SvgPicture.asset(
          assetPath,
          width: 18,
          // ignore: deprecated_member_use
          color: AppColors.white,
        ),
      ),
    );
  }
}
