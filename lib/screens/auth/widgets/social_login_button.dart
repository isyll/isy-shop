import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final Widget child;

  const SocialLoginButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2))
            ]),
        child: child);
  }
}
