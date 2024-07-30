import 'package:flutter/material.dart';
import 'package:isy_shop/theme/colors.dart';

class AppInputTheme {
  static final light = InputDecorationTheme(
      contentPadding: EdgeInsets.zero,
      labelStyle: const TextStyle(letterSpacing: 0.0),
      enabledBorder: _defaultBorder,
      focusedBorder: _defaultBorder,
      filled: true,
      fillColor: Colors.white,
      prefixIconColor: AppColors.lightColorScheme.onSurface.withOpacity(0.5),
      suffixIconColor: AppColors.lightColorScheme.onSurface.withOpacity(0.5),
      hintStyle: TextStyle(
          color: AppColors.lightColorScheme.onSurface.withOpacity(0.5),
          letterSpacing: 0,
          fontWeight: FontWeight.normal));

  static final _defaultBorder = OutlineInputBorder(
      gapPadding: 0.0,
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(5.0));
}
