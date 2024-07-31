import 'package:flutter/material.dart';

class AppColors {
  static const lightColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff45434a),
      onPrimary: Color(0xffffffff),
      secondary: Color(0xffd2953f),
      onSecondary: Color(0xffffffff),
      tertiary: Color(0xff9e9e9e),
      error: Color(0xffffffff),
      onError: Color(0xfff09393),
      surface: Color(0xfff8f8f8),
      onSurface: Color(0xff434343));
}

extension ColorSchemeExtension on ColorScheme {
  Color get onSuccess => const Color(0xff81cea1);
  Color get success => const Color(0xffffffff);
}
