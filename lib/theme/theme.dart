import 'package:flutter/material.dart';
import 'package:isy_shop/theme/button_theme.dart';
import 'package:isy_shop/theme/colors.dart';
import 'package:isy_shop/theme/input_theme.dart';
import 'package:isy_shop/theme/snackbar_theme.dart';
import 'package:isy_shop/theme/text_theme.dart';

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    textTheme: AppTextTheme.light,
    inputDecorationTheme: AppInputTheme.light,
    textButtonTheme: AppTextButtonTheme.light,
    iconButtonTheme: AppIconButtonTheme.light,
    colorScheme: AppColors.lightColorScheme,
    scaffoldBackgroundColor: AppColors.lightColorScheme.surface,
    snackBarTheme: AppSnackbarTheme.light
  );
}
