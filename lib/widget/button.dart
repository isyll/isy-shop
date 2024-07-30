import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final bool disabled;
  final Function() onPressed;

  const Button(
      {super.key,
      required this.text,
      required this.disabled,
      required this.onPressed});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: TextButton(
          style: ButtonStyle(
              padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(vertical: 5)),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide.none)),
              backgroundColor: WidgetStatePropertyAll(disabled
                  ? const Color(0xff949299)
                  : Theme.of(context).colorScheme.primary),
              overlayColor:
                  WidgetStatePropertyAll(Colors.white.withOpacity(0.1))),
          onPressed: disabled ? null : onPressed,
          child: Text(
            text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary, fontSize: 20),
          ),
        ),
      );
}
