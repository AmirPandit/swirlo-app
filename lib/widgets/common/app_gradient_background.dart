import 'package:flutter/material.dart';

class AppGradientBackground extends StatelessWidget {
  final Widget child;

  const AppGradientBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topCenter,
          radius: 1.2,
          colors: [
            Color(0xFFB0AEE0),
            Color(0xFF9555EF),
            Colors.black,
          ],
          stops:[0.0, 0.4, 1.0],
        ),
      ),
      child: child,
    );
  }
}