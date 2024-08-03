import 'package:flutter/material.dart';

import '../../core_ui.dart';

class AppElevatedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const AppElevatedButton({
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius),
        ),
        padding: const EdgeInsets.all(Dimensions.p16),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
