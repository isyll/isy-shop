import 'package:flutter/material.dart';
import 'package:isy_shop/theme/colors.dart';
import 'package:isy_shop/theme/text_theme.dart';

class AppTheme {
  static ThemeData light = ThemeData(
      brightness: Brightness.light,
      colorScheme: AppColors.lightColorScheme,
      textTheme: AppTextTheme.light);
}
