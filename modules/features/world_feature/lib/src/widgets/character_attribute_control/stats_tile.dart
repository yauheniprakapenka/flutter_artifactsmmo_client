import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class StatsTile extends StatelessWidget {
  final String assetPath;
  final String value;
  final String unit;

  const StatsTile({
    required this.value,
    required this.assetPath,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkJungleGreen,
        borderRadius: BorderRadius.circular(Dimensions.radius),
      ),
      padding: const EdgeInsets.symmetric(vertical: Dimensions.p8, horizontal: Dimensions.p16),
      child: Row(
        children: [
          Image.asset(assetPath),
          const AppSpacing.w8(),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.americanSilver,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const AppSpacing.w8(),
          Text(
            unit,
            style: const TextStyle(
              color: AppColors.americanSilver,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
