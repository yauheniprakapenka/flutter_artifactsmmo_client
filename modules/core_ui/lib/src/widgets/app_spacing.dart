import 'package:flutter/material.dart';

import '../design/dimensions.dart';

class AppSpacing extends StatelessWidget {
  final double width;
  final double height;

  const AppSpacing({this.width = 0, this.height = 0});

  const AppSpacing.w8() : this(width: Dimensions.p8);
  const AppSpacing.w16() : this(width: Dimensions.p16);
  const AppSpacing.h8() : this(height: Dimensions.p8);
  const AppSpacing.h16() : this(height: Dimensions.p16);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height);
  }
}
