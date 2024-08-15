import 'package:flutter/material.dart';

extension AppTextStyleMapper on TextStyle {
  TextStyle get withUpheavalFont {
    return copyWith(fontFamily: 'upheaval');
  }
}
