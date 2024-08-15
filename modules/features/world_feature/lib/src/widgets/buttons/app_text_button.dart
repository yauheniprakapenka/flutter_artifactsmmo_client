import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onPressed;

  const AppTextButton({
    required this.title,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius),
          color: isSelected ? AppColors.iluminatingEmerald : AppColors.blackLeatherJacket.withOpacity(0.9),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.p16, vertical: Dimensions.p8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
