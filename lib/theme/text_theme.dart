import 'package:flutter/material.dart';
import 'package:isy_shop/theme/colors.dart';

class AppTextTheme {
  static final light = TextTheme(
    displayLarge: TextStyle(
        color: AppColors.lightColorScheme.onSurface,
        fontSize: 32,
        fontWeight: FontWeight.w500,
        letterSpacing: 0),
    labelMedium: TextStyle(
        color: AppColors.lightColorScheme.onSurface.withOpacity(0.75),
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0),
    bodyMedium: TextStyle(
        color: AppColors.lightColorScheme.onSurface,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        letterSpacing: 0),
  );
}
