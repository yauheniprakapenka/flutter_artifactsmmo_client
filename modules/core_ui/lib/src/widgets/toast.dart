import 'package:flutter/material.dart';

import '../../core_ui.dart';

void showToast(BuildContext context, String message) {
  Toastification().show(
    context: context,
    type: ToastificationType.success,
    style: ToastificationStyle.flat,
    autoCloseDuration: const Duration(seconds: 5),
    description: Text(message, style: const TextStyle(fontSize: 18)),
    alignment: Alignment.topCenter,
    animationDuration: const Duration(milliseconds: 200),
    icon: const Icon(Icons.info),
    showIcon: true,
    primaryColor: AppColors.white,
    backgroundColor: Colors.blue[800],
    foregroundColor: AppColors.white,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(color: Color(0x07000000), blurRadius: 16, offset: Offset(0, 16)),
    ],
    showProgressBar: true,
    progressBarTheme: const ProgressIndicatorThemeData(
      color: AppColors.white,
      linearTrackColor: AppColors.eerieBlack,
    ),
    closeButtonShowType: CloseButtonShowType.onHover,
    closeOnClick: true,
    pauseOnHover: true,
    dragToClose: true,
  );
}
