import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/backgrounds/background.jpeg',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child,
      ],
    );
  }
}
