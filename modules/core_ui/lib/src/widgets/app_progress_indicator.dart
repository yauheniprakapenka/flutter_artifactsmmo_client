import 'package:flutter/material.dart';

import '../../core_ui.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius),
          color: AppColors.white,
        ),
        padding: const EdgeInsets.all(Dimensions.p16),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
