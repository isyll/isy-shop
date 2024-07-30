import 'package:flutter/material.dart';

class AppTextButtonTheme {
  static final light = TextButtonThemeData(
      style: ButtonStyle(
          textStyle: WidgetStateTextStyle.resolveWith((states) {
            if (states.contains(WidgetState.pressed)) {
              return const TextStyle(decoration: TextDecoration.underline);
            }
            return const TextStyle(decoration: TextDecoration.none);
          }),
          shadowColor: const WidgetStatePropertyAll(Colors.transparent),
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)))));
}

class AppIconButtonTheme {
  static const light = IconButtonThemeData(
      style: ButtonStyle(
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)))),
          alignment: Alignment.center,
          backgroundColor: WidgetStatePropertyAll(Colors.white)));
}
