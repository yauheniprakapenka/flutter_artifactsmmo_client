import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class CharacterNameOnMapWidget extends StatelessWidget {
  final String characterName;
  final bool isSelected;
  final double nameVerticalPadding;

  static const double height = 24.0;

  const CharacterNameOnMapWidget({
    required this.characterName,
    required this.isSelected,
    required this.nameVerticalPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CharacterNameWidget(isSelected: isSelected, characterName: characterName),
        SizedBox(height: nameVerticalPadding),
      ],
    );
  }
}

class _CharacterNameWidget extends StatelessWidget {
  final String characterName;
  final bool isSelected;

  const _CharacterNameWidget({
    required this.characterName,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: CharacterNameOnMapWidget.height,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.white : AppColors.blackLeatherJacket,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          characterName,
          style: TextStyle(
            color: isSelected ? AppColors.blackLeatherJacket : AppColors.chineseSilver,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
