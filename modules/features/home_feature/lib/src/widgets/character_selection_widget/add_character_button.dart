import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class AddCharacterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddCharacterButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 70,
        height: 140,
        padding: const EdgeInsets.all(Dimensions.p16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius),
          color: AppColors.blackLeatherJacket.withOpacity(0.95),
        ),
        child: const Center(
          child: Text(
            '+',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.chineseSilver,
            ),
          ),
        ),
      ),
    );
  }
}
