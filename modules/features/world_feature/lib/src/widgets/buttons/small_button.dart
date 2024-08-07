import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback onPressed;

  const SmallButton({
    required this.assetPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
